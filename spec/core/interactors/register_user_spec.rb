require 'spec_helper'

describe Incollage::RegisterUser do
  let(:user_data) do
    { username: 'jd', full_name: 'Johny D', password: 'q1w2e3r4' }
  end
  let(:access_code) { 'secret' }

  before do |example|
    example.with_user_repo
    example.with_holders
  end

  subject do
    ->{ described_class.new(user_data, access_code).execute }
  end

  context 'when new valid user & access code' do
    it do
      is_expected.to change { Incollage::Repository.for_user.count }
    end

    context 'when access code invalid' do
      let(:access_code) { 'random_code' }

      it do
        is_expected.to raise_error(described_class::AccessCodeInvalidError)
      end
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
      expect(subject).to raise_error(described_class::UsernameTakenError)
    end
  end
end
