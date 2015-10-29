class Api::V1::CollageController < ApiController

  def options
    options = Incollage::GetCollageOptions.new.execute
    success options
  end

  def search
    response = Incollage::SearchClippingsForCollage.new(*search_params).execute
    success(SearchedClippingsPresenter.new({ clippings: response })._custom_hash)
  end

  protected

  def search_params
    collections, colors, count = params[:collections], (params[:colors] || ['000']), (params[:count] || 10).to_i
    query = { user_id: current_user.id }
    unless collections.nil?
      query[:collection_id] = collections
    end
    [query, colors, count]
  end

end
