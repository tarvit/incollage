require 'spec_helper'

describe Incollage::GetUserInfo do
  let(:user) { TestFactories::UserFactory.create(id: 100, username: 'jdoe', full_name: 'johny deep') }

  before do |example|
    example.with_user_repo
  end

  subject { described_class.new(user.id).execute }

  it do
    is_expected.to eq(id: 100, username: 'jdoe', full_name: 'johny deep')
  end
end
