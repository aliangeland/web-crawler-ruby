# frozen_string_literal: false

require_relative "crawler/version"
require_relative "crawler/database"
require_relative "crawler/cache"

require "celluloid/autostart"
require "mechanize"

module Crawler
  class CrawlerAgent
    include Celluloid

    attr_accessor :mechanize, :db, :cache

    def initialize()
      @mechanize = Mechanize.new
      @db = Crawler::DB.new
      @cache = Crawler::Cache.new
    end

    def getDetails(link)
      # gets product items of a listing page
      # threads have been used for better performance
      Celluloid::Future.new {
        page = mechanize.get(link)
        page.search(".product-items").css(".product-item-link").each do |a|
          # Celluloid::Future.new {
          if cache.exists("visitedLinks", a[:href])
            # puts "SORRY this link is dup: #{a[:href]}"
          else
            cache.addToSet("visitedLinks", link)
            # gets each product-item's details
            page = mechanize.get(a[:href])
            if page.at_css(".product.attribute.description")
              printPage(page)
            end
          end
        end
      }
    end

    def crawl(link)
      # caches every visited link so that it doesn't crawl it twice
      cache.addToSet("visitedLinks", link)
      page = mechanize.get(link)

      # checks the page if it has a product and extracts it
      if page.at_css(".product.attribute.description")
        printPage(page)
      end

      title = page.search(".page-title").at("span").text
      condition = !page.at_css(".products-related") && !page.at_css(".products-upsell") && page.at_css(".toolbar-products") && title != "Tops" && title != "Bottoms"
      if condition
        # crawling inner pagination
        if page.at_css(".pages-items")
          pagesCount = page.search("ul.pages-items").css(".page").size / 2
          x = 1
          while x <= pagesCount
            getDetails(link + "?p=#{x}")
            x += 1
          end
        else
          getDetails(link)
        end
      end

      # recursive call
      page.search("a").each do |a|
        if cache.exists("visitedLinks", a[:href])
        else
          return crawl(a[:href])
        end
      end

      puts "Crawling finished!"
    end

    def printPage(page)
      productName = page.search(".page-title").at("span").text
      if cache.exists("products", productName)
      else
        productPrice = page.search(".price-wrapper").at("span").text
        productDescription = page.search(".description").at(".value").text
        # formats extra information column
        if page.at_css(".additional-attributes")
          rows = page.search(".additional-attributes").at("tbody")./("tr")
          str = ""
          i = 0
          rows.each do |row|
            i += 1
            st1 = row.at("th").text
            st2 = " : "
            st3 = row.at("td").text
            if i == rows.size
              str << st1 << st2 << st3
              next
            end
            st4 = " | "
            str << st1 << st2 << st3 << st4
          end
          productExtraInfo = str
        else
          productExtraInfo = "N/A"
        end

        # output to console
        puts "Name: " + productName.to_s
        puts "Price: " + productPrice.to_s
        puts "Description: " + productDescription.to_s
        puts "Extra information: " + str.to_s
        puts "--------------------------------------"

        # caches product's name
        cache.addToSet("products", productName)

        # save to DB
        formattedPrice = productPrice.gsub(/[^\d\.]/, "").to_f
        db.saveProduct(productName, formattedPrice, "USD", productDescription, productExtraInfo)
      end
    end
  end
end
