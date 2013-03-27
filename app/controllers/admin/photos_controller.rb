class Admin::PhotosController < Admin::AdminController

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new params[:photo]
    if @photo.save
      flash[:success] = "The image has been successfully uploaded"
      redirect_to admin_photos_path
    else
      flash[:error] = @photo.errors.full_messages.join('<br>')
      redirect_to new_admin_photos_path
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end
end