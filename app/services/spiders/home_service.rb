# frozen_literal: true
require 'kimurai'

class Spiders::HomeService < Kimurai::Base
  @name = 'homes_service'
  @engine = :selenium_chrome

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    items = []
    response.xpath("//li[@class='result-row']").each do |home|
      item = {}

      item[:title] = home.at_css(".result-title.hdrlnk")&.text&.squish
      item[:monthly_rent] = home.at_css(".result-price")&.text&.squish
      item[:address] = home.at_css(".result-hood")&.text&.squish
      item[:url] = home.at_css(".result-title.hdrlnk").attributes["href"].value

      items << item
    end

    Home.create(items)
  end
end
