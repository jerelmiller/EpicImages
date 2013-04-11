class Admin::PhotosController < Admin::AdminController

  def index
    @photos = Photo.order('created_at desc')
  end

  def new
    @photo = Photo.new
    @tags = Tag.all
  end

  def create
    path = admin_photos_path
    ActiveRecord::Base.transaction do
      @photo = Photo.new params[:photo]
      if @photo.save
        @photo.tags = get_tags
        flash[:success] = "The image has been successfully uploaded"
      else
        flash[:error] = @photo.errors.full_messages.join('<br>')
        path = new_admin_photo_path
      end
    end

    redirect_to path
  end

  def edit
    @photo = Photo.find(params[:id])
    @tags = Tag.all
    @photo_tags = @photo.tags
  end

  def update
    @photo = Photo.find(params[:id])
    path = admin_photos_path

    ActiveRecord::Base.transaction do

      if @photo.update_attributes(params[:photo])
        @photo.tags = get_tags
        flash[:success] = "The photo has been successfully updated"
      else
        flash[:error] = @photo.errors.full_messages.join('<br/>')
        path = edit_admin_photo_path(@photo)
      end
    end
    redirect_to path
  end

  private

    def get_tags
      tags = []
      tags << Tag.where(name: params[:tags].split(',')).all
      tags << params[:tags].split(',').reject{ |tag| tags.flatten.map(&:name).include? tag }.map{ |tag| Tag.create(name: tag) }
      tags.flatten
    end
end