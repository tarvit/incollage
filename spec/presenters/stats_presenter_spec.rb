require 'rails_helper'

describe Api::StatsController::StatsPresenter do

  before :each do
    @stats = {
        accounts: [
            {
                :id => 1,
                :name => :test_account,
                :label => 'External Account',
                :linked_account_id => 99,
                :linked => true,
                collections: [
                    {
                        :id => 22,
                        :name => :test_collection,
                        :label => 'Test Collection',
                        :clippings_count => 12,
                    }
                ]
            }
        ]
    }
    @presenter = Api::StatsController::StatsPresenter.new(@stats)
  end

  it 'should present statistics' do
    expect(@presenter.accounts.count).to eq(1)
    expect(@presenter.accounts[0].label).to eq('External Account')
    expect(@presenter.accounts[0].connect_url).to eq('/external_accounts/1/connect')
  end

end
