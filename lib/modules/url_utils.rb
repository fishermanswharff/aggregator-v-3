require 'uri'
require 'open-uri'

module UrlUtils

  def to_uri(string)
    URI(string)
  end
end
