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
      title = doc.css(".entry-title")[k]['title']
      url = doc.css(".entry-title")[k]['href']
      @ss = Shortstory.new(title: title,url: url)
      @ss.save     
    end
  end

end
