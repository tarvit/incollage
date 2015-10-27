require 'rails_helper'

describe Api::V1::StatsController::StatsPresenter do

  before :each do
    @stats = {
        accounts: [
            {
                :id => 11,
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
    @presenter = Api::V1::StatsController::StatsPresenter.new(@stats)
  end

  it 'should present statistics' do
    pp @presenter._custom_hash
    expect(@presenter.accounts.count).to eq(1)
    expect(@presenter.accounts[0].label).to eq('External Account')
    expect(@presenter.accounts[0].connect.url).to eq('/api/v1/external_accounts/11/connect')
    expect(@presenter.accounts[0].connect.label).to eq('Reconnect')
    expect(@presenter.accounts[0].collections[0].sync.url).to eq('/api/v1/external_collections/11/99/sync/22')
  end

end
