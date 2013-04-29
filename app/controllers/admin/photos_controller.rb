class Admin::PhotosController < Admin::AdminController
  before_filter :load_photo, only: [:edit, :update, :destroy]

  def index
    @photos = Photo.order('created_at desc')
    @photo = Photo.new
    @tags = Tag.all
    @galleries = Tag.gallery
  end

  def create
    @photo = Photo.new params[:photo]
    if @photo.save
      @photo.tags = get_tags
      flash[:success] = "The image has been successfully uploaded"
    else
      flash[:error] = @photo.errors.full_messages.join('<br>')
    end

    redirect_to admin_photos_path
  end

  def edit
    @tags = Tag.all
    @photo_tags = @photo.tags
    @galleries = Tag.gallery
  end

  def update
    path = admin_photos_path
    if @photo.update_attributes(params[:photo])
      @photo.tags = get_tags
      flash[:success] = "The photo has been successfully updated"
    else
      flash[:error] = @photo.errors.full_messages.join('<br/>')
      path = edit_admin_photo_path(@photo)
    end
    redirect_to path
  end

  def destroy
    if @photo.destroy
      flash[:success] = "The photo was successfully deleted"
      redirect_to admin_photos_path and return
    else
      flash[:error] = "There was a problem deleting the photo. Please try again"
      redirect_to request.referer
    end
  end

  private

    def get_tags
      tags = []
      tags << Tag.where(name: params[:tags].split(',')).all
      tags << params[:tags].split(',').reject{ |tag| tags.flatten.map(&:name).include? tag }.map{ |tag| Tag.create(name: tag.downcase) }
      tags.flatten
    end

    def load_photo
      @photo = Photo.find(params[:id])
    end
end