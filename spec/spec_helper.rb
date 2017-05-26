require 'bundler'
Bundler.require(:default)

Mongoid.load!("mongoid.yml", :development)

require './app_helper.rb'
Dir["./crawlers/*.rb"].each {|file| require file }
Dir["./models/*.rb"].each {|file| require file }

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
