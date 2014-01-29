class Admin::PhotosController < Admin::AdminController
  before_filter :load_photo, only: [:edit, :update, :destroy, :image]

  def index
    @photos = Photo.order('created_at desc')
    @photo = Photo.new
    @tags = Tag.includes{ photos }.all
    @galleries = Tag.gallery
  end

  def create
    Photo.transaction do
      @photo = Photo.new params[:photo]
      @photo.save

      respond_to do |format|
        format.json
        format.html { redirect_to admin_photos_path }
      end
    end
  end

  def edit
    @tags = Tag.all
    @photo_tags = @photo.tags
    @galleries = Tag.gallery
  end

  def update
    path = admin_photos_path
    if @photo.update_attributes(params[:photo])
      @photo.tags = get_tags params[:tags].split(',')
      flash[:success] = "The photo has been successfully updated"
    else
      flash[:error] = @photo.errors.full_messages.join('<br/>')
      path = edit_admin_photo_path(@photo)
    end
    redirect_to path
  end

  def update_all
    Photo.transaction do
      @photos = Photo.where(id: params[:photos].map{ |param| param[:id] }).all
      filtered_params[:photos].each do |photo_params|
        photo = @photos.select{ |photo| photo.id.eql? photo_params[:id].to_i }.first
        photo.skip_checking_tags = true
        photo.update_attributes photo_params.except :id, :tags
        photo.tags = get_tags photo_params[:tags]
      end
    end
  end

  def destroy
    photo_destroyed = @photo.destroy
    respond_to do |format|
      format.html do
        if photo_destroyed
          flash[:success] = "The photo was successfully deleted"
          redirect_to admin_photos_path and return
        else
          flash[:error] = "There was a problem deleting the photo. Please try again."
          redirect_to request.referer
        end
      end
      format.json do
        render json: { error: 'There was a problem deleting the photo. Please try again.' }, status: :unprocessable_entity and return unless photo_destroyed
        render nothing: true, status: :ok
      end
    end
  end

  def all_photos
    @photos = Photo.order('id desc')
  end

  def image
    render json: { thumb: @photo.image.url(:thumb) }, status: :ok
  end

  private

    def filtered_params
      filtered_params = {}
      if params[:photos].present?
        filtered_params.merge!(
          photos: params[:photos].map do |photo|
            tags = photo[:tags].presence || []
            {
              id: photo[:id],
              caption: photo[:caption],
              featured_flag: photo[:featured_flag],
              tags: tags.map{ |tag| tag[:name] }
            }
          end
        )
      end
      filtered_params
    end

    def get_tags(tag_params)
      tags = []
      tags << Tag.where(name: tag_params).all
      tags << tag_params.reject{ |tag| tags.flatten.map(&:name).include? tag }.map{ |tag| Tag.create(name: tag.downcase) }
      tags.flatten
    end

    def load_photo
      @photo = Photo.find(params[:id])
    end
end