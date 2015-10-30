class Api::V1::ExternalCollectionsController < ApiController
  before_filter :init_ids, only: [ :sync ]

  def sync
    attrs = {
        user_id: current_user.id,
        collection_id: @external_collection_id,
        linked_account_id: @linked_account_id,
    }
    Incollage::SynchronizeRecentClippings.new(attrs).execute
    Incollage::SynchronizePrecedingClippings.new(attrs).execute
    redirect_to :back
  end

  protected

  def init_ids
    @external_account_id = params[:external_account_id].to_i
    @external_collection_id = params[:external_collection_id].to_i
    @linked_account_id = params[:linked_account_id].to_i
  end

end
