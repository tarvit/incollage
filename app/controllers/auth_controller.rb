class AuthController < ApplicationController
  layout 'auth'

  def authenticate
    attrs = params.require(:user).permit(:username, :password)
    Incollage::AuthenticateUser.new(user_session, attrs).execute rescue nil
    if user_session.authorized?
      redirect_to root_path
    else
      @error = 'Credentials are invalid.'
      render :login
    end
  end

  def register
    attrs = params.require(:user).permit(:username, :full_name, :password, :access_code)
    code = attrs.delete(:access_code)
    Incollage::RegisterUser.new(attrs, code).execute
    redirect_to auth_login_path
  rescue Incollage::RegisterUser::UsernameTakenError,
      Incollage::Validateable::BusinessObjectIsInvalidError,
      Incollage::RegisterUser::AccessCodeInvalidError
    @error = 'Sign up error.'
    render :sign_up
  end

  def logout
    user_session.disallow_current_user
    redirect_to root_path
  end
end
