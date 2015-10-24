class AuthController < ApplicationController
  layout 'auth'

  def authenticate
    attrs = params.require(:user).permit(:username, :password)
    Incollage::AuthenticateUser.new(user_session, attrs).execute rescue nil
    if user_session.authorized?
      redirect_to root_path
    else
      @error = 'Credentials are invalid'
      render :login
    end
  end

  def register
    attrs = params.require(:user).permit(:username, :full_name, :password)
    Incollage::RegisterUser.new(attrs).execute
    redirect_to auth_login_path
  rescue Exception => ex
    @error = ex.message
    render :sign_up
  end

  def logout
    user_session.disallow_current_user
    redirect_to root_path
  end

end
