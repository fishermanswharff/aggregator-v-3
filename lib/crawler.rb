require 'nokogiri'
require 'uri'
require 'open-uri'

class Crawler
  def crawl(url)
    page = Nokogiri::HTML(open(url).read)
    # page_uri = URI(url)
    # robots_txt = `curl #{url.gsub(/\/$/, '')}/robots.txt`

    link_attributes = page.xpath('//head').flat_map(&:children).select { |child| child.name == 'link' }.map(&:attributes)
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
    rescue ActiveRecord::RecordNotUnique => e
      Rails.logger.debug "————————— ActiveRecord::RecordNotUnique #{e}—————————"
      # do something?
    end
  end
end
