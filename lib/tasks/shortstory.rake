# coding: utf-8
require 'http'
require 'json'
require 'uri'

namespace :shortstory do
  new_ss_count = 0
  desc "ss_set"
  task :ss_set => :environment do
    doc = ss_scraping
    for k in 0..5 do
      title = doc.css(".entry-title")[k]['title']
      url = doc.css(".entry-title")[k]['href']
      ss = Shortstory.new(title: title,url: url)
      if ss.save
        if (new_ss_count == 0)
          slack_post_text
          new_ss_count += 1
        end
        slack_post(ss)
      end
    end

  end
end

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

  def slack_post(ss)
    uri = URI.parse("https://hooks.slack.com/services/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")
    payload = {
      attachments: [
        {
          title: ss.title,
          text: ss.url,
          color: "#36a64f"
        }
      ]
    }
    Net::HTTP.post_form(uri, { payload: payload.to_json })
  end

   def slack_post_text
    uri = URI.parse("https://hooks.slack.com/services/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")
    payload = {
      text: "<@西村拓海> ssが更新されたよ~"
    }
    Net::HTTP.post_form(uri, { payload: payload.to_json })
  end
