class RootController < ApplicationController

  def index
    if authorized?
      render text: 'AUTH OK'
    else
      redirect_to auth_login_path
    end

  end

end
