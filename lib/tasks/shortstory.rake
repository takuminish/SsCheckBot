namespace :shortstory do

  desc "ss_set"
  task :ss_set => :environment do
    doc = ss_scraping
    title = doc.css(".entry-title")[0]['title']
    url = doc.css(".entry-title")[0]['href']
    ss = Shortstory.new(title: title,url: url)
    ss.save

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

