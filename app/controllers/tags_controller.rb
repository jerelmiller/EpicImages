class TagsController < ApplicationController

  def index
    @galleries = Tag.gallery
    @searchable_tags = Tag.joins(:photos).all
  end

  def show
    @tag = Tag.where('LOWER(name) = ?', filtered_id).first
  end

  def search
    @tags = Tag.joins(:photos).all
    @searched_tags = Tag.where(name: params[:search].split(';'))
    @photos = @searched_tags.map(&:photos).flatten.uniq
  end

  private

    def filtered_id
      params[:id].gsub('-', ' ')
    end
end