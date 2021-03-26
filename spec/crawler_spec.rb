# frozen_string_literal: true
require_relative "spec_helper.rb"
require_relative "../lib/crawler"
require "mechanize"

RSpec.describe Crawler do
  it "has a version number" do
    expect(Crawler::VERSION).not_to be nil
  end

  mechanize = Mechanize.new

  describe ".printPage" do
    context "given no/wrong value as the argument" do
      crawler = Crawler::CrawlerAgent.new

      it "should fail when given no arguments" do
        expect { crawler.printPage() }.to raise_error ArgumentError
      end

      it "should accept one argument" do
        expect { crawler.printPage("s") }.not_to raise_error ArgumentError
      end

      it "should fail with wrong type of argument" do
        expect { crawler.printPage("s") }.to raise_error
      end
    end

    context "given right value as argument" do
      crawler = Crawler::CrawlerAgent.new

      it "should print the desired output if product is new and isn't available on cache" do
        exampleLink = "https://magento-test.finology.com.my/breathe-easy-tank.html"
        page = mechanize.get(exampleLink)

        allow_any_instance_of(Crawler::Cache).to receive(:exists).and_return(false)
        allow_any_instance_of(Crawler::Cache).to receive(:addToSet).and_return(true)
        allow_any_instance_of(Crawler::DB).to receive(:saveProduct).and_return(true)

        expect(crawler.printPage(page)).to be true
      end

      it "shouldn't print anything if product isn't new and is already on cache" do
        exampleLink = "https://magento-test.finology.com.my/breathe-easy-tank.html"
        page = mechanize.get(exampleLink)

        allow_any_instance_of(Crawler::Cache).to receive(:exists).and_return(true)
        allow_any_instance_of(Crawler::Cache).to receive(:addToSet).and_return(false)
        allow_any_instance_of(Crawler::DB).to receive(:saveProduct).and_return(false)

        expect(crawler.printPage(page)).to be nil
      end
    end
  end
end
