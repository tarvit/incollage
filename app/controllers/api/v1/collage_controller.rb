class Api::V1::CollageController < ApiController

  def options
    options = Incollage::GetCollageOptions.new.execute
    success options
  end

end
