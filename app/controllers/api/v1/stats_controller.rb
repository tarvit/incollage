class Api::V1::StatsController < ApiController

  def show
    stats = Incollage::GetUserAccountsStatistics.new(current_user.id).execute
    success AccountStatsPresenter.new(stats)._custom_hash
  end

end
