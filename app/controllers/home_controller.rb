class HomeController < ApplicationController
  def index
    @photos = Photo.featured
    @blog = Blog.most_recent
  end
end