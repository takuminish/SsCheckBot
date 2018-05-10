class ShortstoryController < ApplicationController
  include ShortstoryHelper
  
  def index
    @ss = Shortstory.last(5)
  end

  def new

  end

  def create
    5.times do |k| 
      doc = ss_scraping
      title  = doc.css(".entry-card-content")[k].children[1].children[0]["title"]
      url  = doc.css(".entry-card-content")[k].children[1].children[0]["href"]
      @ss = Shortstory.new(title: title,url: url)
      @ss.save
      
      tags  = doc.css(".entry-card-content")[k].children[3].children[3].css("a")
      tags.each do |tag|
        @t = Tag.new(name: tag.content)
        @t.save
        @s_t = Shortstory_tag.new
      end      
  end

end
