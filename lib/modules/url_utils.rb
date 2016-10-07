require 'uri'
require 'open-uri'

module UrlUtils

  def self.to_uri(string)
    URI(string)
  end
end
