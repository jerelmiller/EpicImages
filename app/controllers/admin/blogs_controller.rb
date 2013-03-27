class Admin::BlogsController < Admin::AdminController

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

  def edit
    @blog = Blog.find params[:id]
  end

  def update
    @blog = Blog.find params[:id]

    if @blog.update_attributes(params[:blog])
      flash[:success] = 'You have successfully updated the blog'
      redirect_to admin_blogs_path
    else
      flash[:error] = @blog.errors.full_messages.join('<br/>')
      render :edit
    end
  end
end