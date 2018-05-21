# coding: utf-8
require 'http'
require 'json'
require 'uri'

namespace :shortstory do
  new_ss_count = 0
  desc "ss_set"
  task :ss_set => :environment do


    doc = ss_scraping
    5.times do |k|
      title = doc.css(".entry-card")[k].children[3].children[1].children[0]["title"]
      url = doc.css(".entry-card")[k].children[3].children[1].children[0]["href"]
      image = doc.css(".entry-card")[k].children[1].children[1].children[0]["src"]
      p title
      ss = Shortstory.new(title: title,url: url, image: image)         
      tags  = doc.css(".entry-card")[k].children[3].children[3].children[3].css("a")
      tags.each do |tag|
        t = Tag.new(name: tag.content)
        if t.save
          ss.tag << t
        else
          ss.tag << Tag.find_by(name: tag.content)
        end
      end
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
    fields = []
    ss.tag.each_with_index do |t,k|
      fields[k] = {:title=>t.name}
    end
    p fields.to_json
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

   def slack_post_text
    uri = URI.parse("https://hooks.slack.com/services/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")
    payload = {
      text: "<@西村拓海> ssが更新されたよ~"
    }
    Net::HTTP.post_form(uri, { payload: payload.to_json })
  end
