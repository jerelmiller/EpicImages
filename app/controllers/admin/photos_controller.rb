class Admin::PhotosController < Admin::AdminController

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new filtered_params
    if @photo.save
      flash[:success] = "The image has been successfully uploaded"
      redirect_to admin_photos_path
    else
      flash[:error] = @photo.errors.full_messages.join('<br>')
      redirect_to new_admin_photo_path
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])

    if @photo.update_attributes(filtered_params)
      flash[:success] = "The photo has been successfully updated"
      redirect_to admin_photos_path
    else
      flash[:error] = @photo.errors.full_messages.join('<br/>')
      redirect_to edit_admin_photo_path(@photo)
    end
  end

  private

    def filtered_params
      params[:photo].merge(
        tags_attributes: params[:tags].split(',').map{ |tag| { name: tag }}
      )
    end
end