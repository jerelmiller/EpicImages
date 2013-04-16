class Admin::GalleriesController < Admin::AdminController

  def index
    @galleries = Gallery.all
  end

  def new
    @gallery = Gallery.new
  end

  def edit
    @gallery = Gallery.find(params[:id])
  end

  def create
    @gallery = Gallery.new(params[:gallery])

    if @gallery.save
      flash[:success] = 'You have successfully created a new gallery'
    else
      flash[:error] = @gallery.errors.full_messages.join('<br/>')
    end
    redirect_to request.referer
  end

  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy

    flash[:success] = "Gallery successfully destroyed"
    redirect_to request.referer
  end
end