require 'rails_helper'

describe FlickrAdapter::ExternalConnector do
  let(:user) { TestFactories::UserFactory.create(id: 28) }
  let(:controller) { TestSupport::FakeController.new }
  let(:connector) do
    FlickrAdapter::ExternalConnector.new(Incollage::Holder.for_external_accounts.added_accounts.first.id)
  end
  let(:instagram_response) do
    {
        external_user_id: '5511',
        meta_info: {
            access_token: 'super_token',
            access_secret: 'super_secret_token',
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

  it 'should connect to Facebook' do
    allow(connector).to receive(:request_token).and_return({ 'oauth_token' => 'tok', 'oauth_token_secret' => 'sec' })
    allow(connector).to receive(:auth_url).and_return('https://api.flickr.com/services/oauth/authorize?oauth_token=tok&perms=read')

    connector.connect(controller, user.id)
    expect(controller.redirects.count).to eq(1)
    expect(controller.redirects.first).to start_with('https://api.flickr.com/services/oauth')
  end

  it 'should respond to Facebook callback' do
    allow(connector).to receive(:fetch_response).and_return(instagram_response)
    result = connector.callback(controller, user.id)
    expect(controller.redirects).to eq([ ?/ ])
    expect(result[:external_user_id]).to eq('5511')
    expect(result[:meta_info][:access_token]).to eq('super_token')
  end
end
