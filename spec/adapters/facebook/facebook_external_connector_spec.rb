require 'rails_helper'

describe FacebookAdapter::ExternalConnector, type: :plain do

  before :each do |example|
    example.with_holders
    example.with_user_repo

    external_account_id = Incollage::Holder.for_external_accounts.added_accounts.first.id
    @user = TestFactories::UserFactory.create(id: 28)
    @controller = TestSupport::FakeController.new
    @connector = FacebookAdapter::ExternalConnector.new(external_account_id)
  end

  it 'should connect to Facebook' do
    @connector.connect(@controller, @user.id)
    expect(@controller.redirects.count).to eq(1)
    expect(@controller.redirects.first).to start_with('https://www.facebook.com/dialog/oauth?')
  end

  it 'should respond to Facebook callback' do
    allow(@connector).to receive(:fetch_response).and_return(instagram_response)
    result = @connector.callback(@controller, @user.id)
    expect(@controller.redirects).to eq([ ?/ ])
    expect(result[:external_user_id]).to eq('5511')
    expect(result[:meta_info][:access_token]).to eq('super_token')
  end

  def instagram_response
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
end
