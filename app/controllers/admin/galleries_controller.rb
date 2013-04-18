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
    ActiveRecord::Base.transaction do
      @gallery = Gallery.new(params[:gallery])

      if @gallery.save
        create_tag
        flash[:success] = 'You have successfully created a new gallery'
      else
        flash[:error] = @gallery.errors.full_messages.join('<br/>')
      end
      redirect_to request.referer
    end
  end

  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy

    flash[:success] = "Gallery successfully destroyed"
    redirect_to request.referer
  end

  private

    def create_tag
      @tag = Tag.where(name: @gallery.name).first_or_initialize
      @tag.save if @tag.new_record?
    end
end