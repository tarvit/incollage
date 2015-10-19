require 'spec_helper'

describe Incollage::AuthorizeUser do

  before :each do
    @user = TestFactories::UserFactory.create(username: 'coolname', password: 'coolpass_123')
    @session = TestSupport::FakeAbstractService.new(:authenticate)
  end

  it 'should authorize a user with valid creds' do
    expect(@session).to receive(:authenticate).with(@user.id)
    Incollage::AuthorizeUser.new(@session, username: 'coolname', password: 'coolpass_123').execute
  end

  it 'should raise error if user doesn\'t exists' do
    expect(@session).to_not receive(:authenticate)
    expect(->{
      Incollage::AuthorizeUser.new(@session, username: 'coolname2', password: 'awsomepass22').execute
    }).to raise_error(Incollage::AuthorizeUser::AuthenticationFailedError)
  end

  it 'should raise error if username is not passed' do
    expect(@session).to_not receive(:authenticate)
    expect(->{
      Incollage::AuthorizeUser.new(@session, password: 'awsomepass22').execute
    }).to raise_error(Incollage::AuthorizeUser::AuthenticationFailedError)
  end

  it 'should raise error if password is not passed' do
    expect(@session).to_not receive(:authenticate)
    expect(->{
      Incollage::AuthorizeUser.new(@session, password: 'coolpass_123').execute
    }).to raise_error(Incollage::AuthorizeUser::AuthenticationFailedError)
  end

  it 'should raise error if password is invalid' do
    expect(@session).to_not receive(:authenticate)
    expect(->{
      Incollage::AuthorizeUser.new(@session, username: 'coolname', password: 'invalid_password').execute
    }).to raise_error(Incollage::AuthorizeUser::AuthenticationFailedError)
  end

end
