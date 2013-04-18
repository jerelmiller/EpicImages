class TagsController < ApplicationController

  def search
    @tags = Tag.joins(:photos).all
    @searched_tags = Tag.where(name: params[:search].split(';'))
    @photos = @searched_tags.map(&:photos).flatten.uniq
  end
end