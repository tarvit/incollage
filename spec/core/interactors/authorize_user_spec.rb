require 'spec_helper'

describe Incollage::AuthenticateUser do
  let(:user) { TestFactories::UserFactory.create(username: 'coolname', password: 'coolpass_123') }
  let(:session) { TestSupport::FakeAbstractService.new(:certify_user) }
  let(:username) { user.username }
  let(:password) { user.password }

  before do |example|
    example.with_user_repo
  end

  def execute
    Incollage::AuthenticateUser.new(session, username: username, password: password).execute
  end

  context 'when valid credentials' do
    it do
      expect(session).to receive(:certify_user).with(user.id)
      execute
    end
  end

  context 'when invalid credentials' do
    shared_examples 'authentication error' do
      it do
        expect(session).to_not receive(:certify_user)
        expect{ execute }.to raise_error(Incollage::AuthenticateUser::AuthenticationFailedError)
      end
    end

    context 'password is invalid' do
      let(:password) { 'invalid_password' }

      include_examples 'authentication error'
    end

    context 'username & password are invalid' do
      let(:username) { 'coolname2' }
      let(:password) { 'awsomepass22' }

      include_examples 'authentication error'
    end

    context 'username is nil' do
      let(:username) { nil }

      include_examples 'authentication error'
    end
  end
end
