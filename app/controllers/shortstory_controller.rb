class ShortstoryController < ApplicationController
  include ShortstoryHelper
  
  def index
    @ss = Shortstory.last(5)
  end

  def new

  end

  def create
    doc = ss_scraping
    title = doc.css(".entry-title")[0]['title']
    url = doc.css(".entry-title")[0]['href']
    @ss = Shortstory.new(title: title,url: url)
    if @ss.save
      redirect_to ss_path
    else
      render 'new'
    end
  end

end
