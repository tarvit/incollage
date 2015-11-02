require 'rails_helper'

describe InstagramAdapter::ExternalConnector do

  before :each do
    external_account_id = Incollage::Holder.for_external_accounts.added_accounts.first.id
    @user = TestFactories::UserFactory.create(id: 28)
    @controller = TestSupport::FakeController.new
    @connector = InstagramAdapter::ExternalConnector.new(external_account_id)
  end

  it 'should connect to Instagram' do
    @connector.connect(@controller, @user.id)
    expect(@controller.redirects.count).to eq(1)
    expect(@controller.redirects.first).to start_with('https://api.instagram.com/oauth/authorize/?')
  end

  it 'should respond to Instagram callback' do
    allow(@connector).to receive(:fetch_response).and_return(instagram_response)
    expect(@connector).to receive(:on_connected)

    @connector.callback(@controller, @user.id)
    expect(@controller.redirects).to eq([ ?/ ])
  end

  def instagram_response
    TarvitHelpers::HashPresenter.present({
       access_token: 'super_token',
       user: {
           id: '5511',
           username: 'jdex'
       }
   })
  end
end
