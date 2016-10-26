require 'nokogiri'
require 'uri'
require 'open-uri'

class Spider
  include UrlUtils

  attr_accessor :already_visited,
    :next_urls,
    :current_url

  def initialize
    @already_visited = {} # turn this into indexing in a db? maybe mongo?
    @next_urls = []
    @current_url = ''
  end

  def crawl_web(*urls, depth: 2, page_limit: 100)
    depth.times do |i|
      urls.flatten.each do |url|
        @current_url = url
        url_object = open(url) # open the url
        next if url_object.nil? # if the url doesn't open, next
        url = update_if_redirected(url, url_object) # if url is a redirect, return the url's base_uri
        raw_html = url_object.read # extract the raw html from the url_object
        doc = Nokogiri::HTML(raw_html) # turn the url content into a Nokogiri object
        next if doc.nil? # continue to the next one if there's no doc
        @already_visited[url] = true # save the url, because we've visited it.
        if @already_visited.keys.length == page_limit # if we've visited the page_limit count, return
          # write a csv file
          # single column
          # header => url
          # iterate through next_urls that haven't been visited, write them to the file
          # use this file to start the next crawl
          return
        end
        Rails.logger.debug "parsing url: #{url}, current depth: #{i}, number links visited: #{already_visited.keys.length}"
        @next_urls = next_urls.concat(scrape_page_links(doc: doc, current_url: url) - already_visited.keys) # add to next_urls by parsing the page of all urls on the page, minus already_visited
        @next_urls.uniq! # we only want unique urls
      end
      urls = next_urls
    end
  rescue => e
    Rails.logger.debug "Error parsing url #{current_url}: #{e}"
    # current_url caused an error, lets get rid of it
    next_urls.delete(current_url) if next_urls.include?(current_url)
    @already_visited.delete(current_url) if @already_visited.keys.include?(current_url)
    crawl_web(next_urls - @already_visited.keys)
  ensure
    Rails.logger.info "Urls parsed: #{@already_visited.keys.join(', ')}"
    @already_visited = {}
    @next_urls = []
    @current_url = ''
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
    current_uri = to_uri(current_url)
    urls.map do |url|
      uri = to_uri(url)
      uri.relative? ? current_uri.merge(uri) : uri.to_s
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
      Rails.logger.debug "Error parsing head #{url}: #{e}"
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
    Rails.logger.debug "Error parsing url #{url}: #{e}"
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
