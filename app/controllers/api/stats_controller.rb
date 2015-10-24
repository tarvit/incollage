class Api::StatsController < ApiController

  def show
    success Incollage::GetUserAccountsStatistics.new(current_user.id).execute
  end

end
