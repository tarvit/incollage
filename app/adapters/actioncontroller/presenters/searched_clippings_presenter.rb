class SearchedClippingsPresenter < BasePresenter

  protected

  def _modify_hash(clippings)
    clippings = clippings[:clippings].map{|x| { url: x[:picture_url] } }
    {
        pictures: clippings
    }
  end

  def _add_rules(rules); end

end
