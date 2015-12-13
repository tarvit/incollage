require 'rails_helper'

describe AccountStatsPresenter do
  let(:presenter) do
    described_class.new(TestFactories::StatsFactory.get)
  end

  it 'should present statistics' do
    expect(presenter.accounts.count).to eq(1)
    expect(presenter.accounts[0].label).to eq('External Account')
    expect(presenter.accounts[0].connect.url).to eq('/api/v1/external_accounts/11/connect')
    expect(presenter.accounts[0].connect.label).to eq('Reconnect')
    expect(presenter.accounts[0].collections[0].sync.url).to eq('/api/v1/external_collections/11/99/sync/22')
  end
end
