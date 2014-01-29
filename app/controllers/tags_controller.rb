class TagsController < ApplicationController

  def index
    @galleries = Tag.gallery.with_photos.includes(:photos)
    @searchable_tags = Tag.all
  end

  def show
    @tag = Tag.where('LOWER(name) = ?', filtered_id).includes(:photos).first
  end

  def search
    @tags = Tag.joins(:photos).includes(:photos).all
    @searched_tags = Tag.where(name: params[:search].split(';')).includes(:photos)
    @photos = @searched_tags.map(&:photos).flatten.uniq
  end

  private

    def filtered_id
      params[:id].gsub('-', ' ')
    end
end