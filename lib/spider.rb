require 'nokogiri'
require 'uri'
require 'open-uri'

class Spider
  attr_reader :already_visited

  def initialize
    @already_visited = {}
  end

  def crawl_web(*urls, depth: 2, page_limit: 100)
    # depth.times do
    # end
    html = open(urls.first).read
    page = Nokogiri::HTML(html)
    page_uri = URI(urls.first)
    # robots_txt = `curl #{url.gsub(/\/$/, '')}/robots.txt`
    # feeds_added = []
    # head_links = parse_head(url: url, html: page.xpath('//head'))
    # body_links = parse_body(url: url, html: page.xpath('//body'))
  end

  def scrape_links(url: '', nk_obj:)
    parse_body(url: url, html: nk_obj.xpath('//body'))
  end

  def parse_head(url: '',html: '')
    link_attributes = html[0].flat_map(&:children).select { |child| child.name == 'link' }.map(&:attributes)
    rss_links = link_attributes.select { |link| link['type']&.value == 'application/rss+xml' }
    begin
      ActiveRecord::Base.transaction do
        rss_links.map do |link|
          link_uri = URI(link['href'])
          Feed.find_or_create_by(url: link_uri.absolute? ? link_uri.to_s : url + link['href']) do |feed|
            feed.name = link['title']
            feed.save!
          end
        end
      end
    rescue => e
    end
  end

  def parse_body(url: '', html: '')
    body = html.first
    links = body.xpath('//a')
    rss_links = links.map(&:attributes).map { |attr| attr['href'] }.compact.select do |attr|
      attr.value.split('.').last.split('?').first.match(/xml|rss/)
    end
    saved_feeds = rss_links.map do |link|
      f =  Feed.new(url: link.value)
      if f.valid? && f.valid_feed? && !Feed.find_by(url: link.value)
        f.save
        f
      else
        next
      end
    end
  rescue => e
  ensure
    return saved_feeds
  end

  private

  def current_link
    @current_link
  end

  def current_link=(value)
    @current_link = value
  end
end
