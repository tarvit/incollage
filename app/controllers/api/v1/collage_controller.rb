class Api::V1::CollageController < ApiController

  def options
    options = Incollage::GetCollageOptions.new.execute
    success options
  end

  def search
    response = found_clippings.map do |clipping|
      { id: clipping.id, picture_url: clipping.picture.url }
    end
    success(SearchedClippingsPresenter.new({ clippings: response })._custom_hash)
  end

  def make
    collage_url = Incollage::MakeCollage.new(found_clippings, current_user.id).execute
    success collage: collage_url
  end

  protected

  def search_params
    collections, colors, count = params[:collections], (params[:colors] || ['000000']), (params[:count] || 10).to_i
    query = { user_id: current_user.id }
    unless collections.nil?
      query[:collection_id] = collections
    end
    [query, colors, count]
  end

  def found_clippings
    Incollage::SearchClippingsForCollage.new(*search_params).execute
  end

end
