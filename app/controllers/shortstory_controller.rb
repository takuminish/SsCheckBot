class ShortstoryController < ApplicationController
  include ShortstoryHelper
  
  def index
    @ss = Shortstory.last(5)
  end

  def new

  end

  def create
    doc = ss_scraping
    5.times do |k| 
      title  = doc.css(".entry-card-content")[k].children[1].children[0]["title"]
      url  = doc.css(".entry-card-content")[k].children[1].children[0]["href"]
      @ss = Shortstory.new(title: title,url: url)         
      tags  = doc.css(".entry-card-content")[k].children[3].children[3].css("a")
      tags.each do |tag|
        t = Tag.new(name: tag.content)
        if t.save
          @ss.tag << t
        else
          @ss.tag << Tag.find_by(name: tag.content)
        end
      end
      @ss.save
    end
  end

end
