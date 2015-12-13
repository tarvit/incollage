require 'spec_helper'

describe Incollage::UserSession do
  let(:instance) { described_class.new({}) }
  let(:user) { TestFactories::UserFactory.create }

  before do |example|
    example.with_user_repo
  end

  it 'should authenticate user' do
    # in initial state we don't have an authorized user
    expect(instance.authorized?).to be_falsey
    expect(instance.current_user_id).to be_nil

    instance.certify_user(user.id)

    # we have the user now
    expect(instance.authorized?).to be_truthy
    expect(instance.current_user_id).to eq(user.id)

    instance.disallow_current_user

    # session is empty
    expect(instance.authorized?).to be_falsey
    expect(instance.current_user_id).to be_nil
  end
end
