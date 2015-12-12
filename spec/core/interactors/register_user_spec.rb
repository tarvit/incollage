require 'spec_helper'

describe Incollage::RegisterUser do
  let(:user_data) do
    { username: 'jd', full_name: 'Johny D', password: 'q1w2e3r4' }
  end

  before do |example|
    example.with_user_repo
  end

  subject do
    ->{ Incollage::RegisterUser.new(user_data).execute }
  end

  context 'when new valid user' do
    it do
      is_expected.to change { Incollage::Repository.for_user.count }
    end
  end

  context 'when no password' do
    let(:user_data) do
      {username: 'jd', full_name: 'Johny D'}
    end

    it do
      is_expected.to raise_error(Incollage::Validateable::BusinessObjectIsInvalidError)
    end
  end

  context 'when duplicated username' do
    it do
      subject.call
      expect(subject).to raise_error(Incollage::RegisterUser::UsernameTakenError)
    end
  end
end
