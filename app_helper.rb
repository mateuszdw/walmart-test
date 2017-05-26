require 'open-uri'

HOST = 'https://www.walmart.com'
USER_AGENT = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.86 Safari/537.36"

def get_request(req)
  Nokogiri::HTML(open(req, 'User-Agent' => USER_AGENT), nil, "UTF-8")
rescue OpenURI::HTTPError => e
  puts "## Request error #{e}"
  return false
end
