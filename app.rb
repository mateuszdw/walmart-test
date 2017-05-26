require 'bundler'
Bundler.require(:default)

Mongoid.load!("mongoid.yml", :development)

require './app_helper.rb'
Dir["./crawlers/*.rb"].each {|file| require file }
Dir["./models/*.rb"].each {|file| require file }

crawled_product = ProductCrawler.new('Ematic-9-Dual-Screen-Portable-DVD-Player-with-Dual-DVD-Players-ED929D/28806789')

# find or create product if needed
product = Product.first_or_initialize(name: crawled_product.name)
product.price = crawled_product.price

# find or create product reviews
crawled_product.reviews_bodies.each do |review_body|
  unless product.reviews.where_body_hash(review_body).first
    product.reviews.build(body: review_body)
  end
end

puts ">>> Product saved!" if product.save!

# if ARGV given search in reviews
if !ARGV.empty?
  keywords = ARGV.first
  keywords_array = keywords.split(' ').map {|word| /#{word}/}
  reviews_results = Review.in(body: keywords_array)
  puts ">>> Keywords: #{keywords}"
  puts ""
  puts ">>> Review results: "
  reviews_results.each do |review|
    puts review.body
    puts "---------"
  end
else
  puts 'Start $ruby app.rb "keyword1 keyword2" to search by given keywords'
end
