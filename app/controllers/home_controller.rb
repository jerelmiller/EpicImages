class HomeController < ApplicationController
  def index
    @photos = Photo.all
    @blog = Blog.most_recent
  end
end