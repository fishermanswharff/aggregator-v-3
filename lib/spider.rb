require 'nokogiri'
require 'uri'
require 'open-uri'

class Spider
  attr_reader :already_visited

  def initialize
    @already_visited = {} # turn this into indexing in a db? maybe mongo?
  end

  def crawl_web(*urls, depth: 2, page_limit: 100)
    next_urls = []
    depth.times do |i|
      urls.flatten.each do |url|
        puts "parsing url: #{url}, current depth: #{i}, number links visited: #{already_visited.keys.length}"
        # open the url
        url_object = open(url)
        # if the url doesn't open, next
        next if url_object.nil?
        # if url is a redirect, return the url's base_uri
        url = update_if_redirected(url, url_object)
        # extract the raw html from the url_object
        raw_html = url_object.read
        # turn the url content into a Nokogiri object (parsed_url)
        doc = Nokogiri::HTML(raw_html)
        # continue to the next one if there's no doc
        next if doc.nil?
        # save the url, because we've visited it.
        already_visited[url] = true
        # if we've visited the page_limit count, return
        return if already_visited.keys.length == page_limit
        # add to next_urls by parsing the page of all urls on the page, minus already_visited
        next_urls.concat(scrape_page_links(doc: doc, current_url: url) - already_visited.keys)
        next_urls.uniq!
      end
      urls = next_urls
    end
  rescue => e
    crawl_web(next_urls)
  end

  def open_url(url)
    url_object = open(url)
  rescue
    p 'Unable to open url: ' + url
  ensure
    return url_object
  end

  def update_if_redirected(url, url_object)
    unless url == url_object.base_uri.to_s
      return url_object.base_uri.to_s
    end
    url
  end

  def scrape_page_links(doc:, current_url:)
    urls = doc.xpath('//a').map(&:attributes).map { |attr| attr['href']&.value }.compact
    urls.map do |url|
      uri = UrlUtils.to_uri(url)
      uri.relative? ? current_url.chomp('/') + "/#{url}" : uri.to_s
    end
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
