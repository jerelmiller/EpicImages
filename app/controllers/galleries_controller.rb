class GalleriesController < ApplicationController

  def index
    @galleries = Gallery.all
    @tags = Tag.joins(:photos).all
    @searched_tags = Tag.where(name: params[:search].split(';')).all if params[:search]
  end

  def show
    @tag = Tag.where('LOWER(name) = ?', filtered_id).first
  end

  private

    def filtered_id
      params[:id].gsub('-', ' ')
    end
end