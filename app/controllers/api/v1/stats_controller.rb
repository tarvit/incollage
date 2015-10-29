class Api::V1::StatsController < ApiController

  def show
    stats = Incollage::GetUserAccountStatistics.new(current_user.id).execute
    success AccountStatsPresenter.new(stats)._custom_hash
  end

end
