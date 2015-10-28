class BasePresenter < TarvitHelpers::HashPresenter::Custom

  def _route
    Rails.application.routes.url_helpers
  end

end
