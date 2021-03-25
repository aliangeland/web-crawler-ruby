# frozen_string_literal: true
require_relative "spec_helper.rb"
require_relative "../lib/crawler.rb"
require "mechanize"

RSpec.describe Crawler do
  it "has a version number" do
    expect(Crawler::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end

  mechanize = Mechanize.new

  describe ".printPage" do
    context "given no/wrong value as argument" do
      crawler = Crawler.new(mechanize)
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
      crawler = Crawler.new(mechanize)
      before(:each) do
        cache = double("cache")
        $cache = cache
        $cache.stub(:exists) { true }
      end
      it "should print the desired output" do
        exampleLink = "https://magento-test.finology.com.my/breathe-easy-tank.html"
        page = mechanize.get(exampleLink)
        # $cache.stub(:exists).with("products", "Breathe-Easy Tank") { 1 }
        # allow($cache).to receive(:exists).and_return(1)
        # $cache = double()
        # expect($cache).to receive(:exists).and_return(true)
        # mock_cache = mock(:exists => mock)
        # Kernel.stub(:Redis) { true }
        # allow_any_instance_of($cache).to receive(:exists).and_return(true)
        # $cache = Cache.new
        # allow_any_instance_of(Cache).to receive(:exists) { 1 }
        text = crawler.printPage(page)
        puts text
        # allow($cache).to receive(:exists).with(1) {
        #   text = crawler.printPage(page)
        #   puts text
        # }
        # $cache.stub(exists: true)

      end
    end
  end
end
