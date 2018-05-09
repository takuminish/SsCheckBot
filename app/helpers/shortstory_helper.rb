require 'nokogiri'
require 'open-uri'

module ShortstoryHelper

  def ss_scraping
    url = "http://www.lovelive-ss.com"

    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
    return doc
  end
end
