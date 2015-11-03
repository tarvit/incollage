class CollageOptionsPresenter < BasePresenter

  protected

  def _modify_hash(account_stats)
    collections = account_stats[:accounts].map{|x| x[:collections] }.flatten(1)
    {
        search: {  collections: collections },
    }
  end

end
