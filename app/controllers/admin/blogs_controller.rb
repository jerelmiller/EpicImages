class Admin::BlogsController < Admin::AdminController
  before_filter :load_blog, only: [:edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new params[:blog]

    if @blog.save
      flash[:success] = 'You have successfully created a new blog'
      redirect_to admin_blogs_path
    else
      flash[:error] = @blog.errors.full_messages.join('<br/>')
      render :new
    end
  end

  def update
    if @blog.update_attributes(params[:blog])
      flash[:success] = 'You have successfully updated the blog'
      redirect_to admin_blogs_path
    else
      flash[:error] = @blog.errors.full_messages.join('<br/>')
      render :edit
    end
  end

  def destroy
    if @blog.destroy
      flash[:success] = 'You have successfully deleted the blog'
    else
      flash[:error] = 'Could not delete the blog. Please try again'
    end
    redirect_to admin_blogs_path
  end

  private

    def load_blog
      @blog = Blog.find params[:id]
    end
end