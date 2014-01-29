class Admin::AdminController < ApplicationController
  before_filter :require_login
  layout 'admin'

  def index
    @photos = Photo
  end

end