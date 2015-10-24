class ApiController < ApplicationController
  before_filter :check_authorized!

  def success(response)
    render json: response
  end

end
