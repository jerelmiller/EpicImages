class Admin::AdminController < ApplicationController
  before_filter :require_login
  layout 'admin'

  # def index
  #   @recent_images = Image.limit(5).where('created_at > ?', 5.days.ago).order('created_at desc')
  # end

end