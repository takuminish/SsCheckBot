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
    p doc
    p ENV["NOKOGIRI_URL"]
    15.times do |k|
      ss_title = doc.css(".title")[k].children[1].children[1].text
      ss_url = doc.css(".title")[k].children[1].children[1]["href"]
      ss = Shortstory.new(title: ss_title, url: ss_url)
      tag = doc.css(".words")[k].text
      ss_tag = Tag.new(name: tag)
      if ss_tag.save
        ss.tag << ss_tag
      else
        ss.tag << Tag.find_by(name: tag)
      end
      if ss.save
        if (new_ss_count == 0)
          slack_post_text(ENV["SLACK_POST_URL"])
          new_ss_count += 1
        end
        slack_post(ss,ENV["SLACK_POST_URL"])
      end
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

  def slack_post(ss,url)
    uri = URI.parse(url)
    fields = []
    ss.tag.each_with_index do |t,k|
      fields[k] = {:title=>t.name}
    end
    payload = {
      attachments: [
        {
          title: ss.title,
          title_link:  ss.url,
          fields: fields,
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
