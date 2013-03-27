class Admin::UsersController < Admin::AdminController

  def update
    if current_user.update_attributes(params[:user])
      flash[:success] = 'Your user information has been successfully updated'
    else
      flash[:error] = current_user.errors.full_messages.join('<br/>')
    end

    redirect_to edit_admin_users_path
  end
end