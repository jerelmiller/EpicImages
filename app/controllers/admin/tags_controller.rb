class Admin::TagsController < Admin::AdminController
  def index
    @galleries = Tag.gallery
  end

  def show
    @gallery = Tag.gallery.where('LOWER(name) = ?', filtered_id).first
  end

  private

    def filtered_id
      params[:id].gsub('-', ' ')
    end
end