class ProductCrawler

  PRODUCTS_PATH = '/ip/'

  attr_reader :html

  def initialize(product_path)
    @product_url = HOST + PRODUCTS_PATH
    @html = get_request(@product_url + product_path)
  end

  def name
    @html.css('.prod-ProductTitle div').text
  end

  def price
    @html.css('span[itemprop="price"]').first["content"]
  end

  def reviews
    @review_html = get_request(HOST + all_reviews_url + '?limit=200')
    @review_html.css("div.customer-review-text")
  end

  def reviews_bodies
    reviews.map { |r| r.text.strip }
  end

private

  def all_reviews_url
    @html.css('.ReviewsHeader-seeAll').map {|a| a['href'] }.first
  end

end
