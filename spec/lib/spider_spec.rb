require 'rails_helper'
require 'rss'

RSpec.describe Spider do
  let(:spider) { Spider.new }
  let(:url) { FactoryGirl.create(:nytimes_homepage_feed) }
  let(:html) { File.read(File.join(Rails.root, 'spec', 'fixtures', 'nytimes_fixture.html')) }

  before :each do
    allow(RSS::Parser)
      .to receive(:parse)
      .with(anything())
      .and_return(FactoryGirl.build(:rss_parsed_feed))
    
    allow(Feedjira::Feed)
      .to receive(:fetch_and_parse)
      .with(anything())
      .and_return(FactoryGirl.build(:feedjira_parsed_feed))
  end

  describe 'spider' do
    it 'is an instance of Spider' do
      expect(spider).to be_a Spider
    end
  end

  describe '#crawl_web' do
    it 'crawls the web' do
      results = spider.crawl_web(url)
      expect(results).to be_truthy
    end
  end

  describe '#scrape_links' do
    it 'scrapes the links on a page at the given url, and returns them' do
      parsed_feeds = spider.scrape_links(nk_obj: Nokogiri::HTML(html))
      expect(parsed_feeds.length).to eq 72
    end
  end
end
