class BlogsController < ApplicationController
  def index
    @blogs = Blog.order_most_recent
  end

  def show
    @blog = Blog.find(params[:id])
  end
end