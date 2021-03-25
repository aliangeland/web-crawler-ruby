require_relative "../lib/crawler"

beginingLink = "https://magento-test.finology.com.my/breathe-easy-tank.html"

crawler = Crawler::CrawlerAgent.new

begin
  crawler.crawl(beginingLink)
rescue Timeout::Error
  puts "Timeout"
  retry
rescue Net::HTTPGatewayTimeOut => e
  if e.response_code == "504" || e.response_code == "502"
    e.skip
    sleep 5
  end
rescue Net::HTTPBadGateway => e
  if e.response_code == "504" || e.response_code == "502"
    e.skip
    sleep 5
  end
rescue Net::HTTPNotFound => e
  if e.response_code == "404"
    e.skip
    sleep 5
  end
rescue Net::HTTPFatalError => e
  if e.response_code == "503"
    e.skip
  end
rescue Mechanize::ResponseCodeError => e
  if e.response_code == "404"
    e.skip
    sleep 5
  elsif e.response_code == "502"
    e.skip
    sleep 5
  else
    retry
  end
rescue Mechanize::UnsupportedSchemeError => e
  puts "Finished crawling"
rescue Errno::ETIMEDOUT
  retry
end
