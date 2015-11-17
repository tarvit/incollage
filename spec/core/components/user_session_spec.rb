require 'spec_helper'

describe Incollage::UserSession do

  before :each do |example|
    example.with_user_repo

    @session = Incollage::UserSession.new({})
    @user = TestFactories::UserFactory.create
  end

  it 'should authenticate user' do
    # in initial state we don't have an authorized user
    expect(@session.authorized?).to be_falsey
    expect(@session.current_user_id).to be_nil

    @session.certify_user(@user.id)

    # we have the user now
    expect(@session.authorized?).to be_truthy
    expect(@session.current_user_id).to eq(@user.id)

    @session.disallow_current_user

    # session is empty
    expect(@session.authorized?).to be_falsey
    expect(@session.current_user_id).to be_nil
  end

end
