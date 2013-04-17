class GalleriesController < ApplicationController

  def index
    @galleries = Gallery.all
  end

  def show
    @gallery = Gallery.where('LOWER(name) = ?', filtered_id).first
  end

  private

    def filtered_id
      params[:id].gsub('-', ' ')
    end
end