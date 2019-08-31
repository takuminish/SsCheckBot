# coding: utf-8
require 'http'
require 'json'
require 'uri'
require 'dotenv'

namespace :shortstory do
  desc "ss_set"
  task :ss_set => :environment do
    new_ss_count = 0
    Dotenv.load
    doc = ss_scraping(ENV["NOKOGIRI_URL"])
    5.times do |k|
    title = doc.css(".title")[k].children[1].children[1].text
    url = doc.css(".title")[k].children[1].children[1]["href"]
    tag = doc.css(".words")[k].text

    end
  end
end

   def ss_scraping(url)
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
    return doc
  end
=begin
  def slack_post(ss,url)
    uri = URI.parse(url)
    fields = []
    ss.tag.each_with_index do |t,k|
      fields[k] = {:title=>t.name}
    end
    p url
    payload = {
      attachments: [
        {
          title: ss.title,
          title_link:  ss.url,
          fields: fields,
          thumb_url: ss.image,
          color: "#36a64f"
        }
      ]
    }
    Net::HTTP.post_form(uri, { payload: payload.to_json })
  end

  def slack_post_text(url)
     uri = URI.parse(url)
    payload = {
      text: "<@西村拓海> ssが更新されたよ~"
    }
    Net::HTTP.post_form(uri, { payload: payload.to_json })
  end
=end