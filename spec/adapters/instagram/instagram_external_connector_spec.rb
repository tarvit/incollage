require 'rails_helper'

describe InstagramAdapter::ExternalConnector do
  let(:user) { TestFactories::UserFactory.create(id: 28) }
  let(:controller) { TestSupport::FakeController.new }
  let(:connector) do
    external_account_id = Incollage::Holder.for_external_accounts.added_accounts.first.id
    described_class.new(external_account_id)
  end
  let(:instagram_response) do
    {
        external_user_id: '5511',
        meta_info: {
            access_token: 'super_token',
            user: {
                id: '5511',
                username: 'jdex'
            }
        }
    }
  end

  before do |example|
    example.with_holders
    example.with_user_repo
  end

  it 'should connect to Instagram' do
    connector.connect(controller, user.id)
    expect(controller.redirects.count).to eq(1)
    expect(controller.redirects.first).to start_with('https://api.instagram.com/oauth/authorize/?')
  end

  it 'should respond to Instagram callback' do
    allow(connector).to receive(:fetch_response).and_return(instagram_response)
    result = connector.callback(controller, user.id)
    expect(controller.redirects).to eq([ ?/ ])
    expect(result[:external_user_id]).to eq('5511')
    expect(result[:meta_info][:access_token]).to eq('super_token')
  end
end
