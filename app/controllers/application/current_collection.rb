module ApplicationControllerCurrentCollection

  extend ActiveSupport::Concern

  included do
    helper_method :current_clippings_collection
  end

  def current_collection_id
    (cookies[:current_collection_id] || Incollage::Service.for_clippings_collection_holder.first_collection.id).to_i
  end

  def current_clippings_collection
    Incollage::Service.for_clippings_collection_holder.get(current_collection_id)
  end

  def current_user_collection
    Incollage::UserClippingsCollection.new(current_user.id, current_collection_id)
  end

end
