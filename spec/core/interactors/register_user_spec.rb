require 'spec_helper'

describe Incollage::RegisterUser do

  before :each do
    @user_data = {username: 'jd', full_name: 'Johny D'}
  end

  it 'should find or create a user' do
    expect(Incollage::Repository.for_user.count).to eq(0)

    # Saving without a password causes error
    expect(->{
      Incollage::RegisterUser.new(@user_data).execute
    }).to raise_error(Incollage::Entity::EntityIsInvalidError)

    expect(Incollage::Repository.for_user.count).to eq(0)

    # Saving with a password works correctly
    expect(->{
      Incollage::RegisterUser.new(
          @user_data.merge(password: 'q1w2e3r4')
      ).execute
    }).to change{ Incollage::Repository.for_user.count }.by(1)

    # Duplicated entity causes error
    expect(->{
      Incollage::RegisterUser.new(
          @user_data.merge(password: 'q1w2e3r4')
      ).execute
    }).to raise_error(Incollage::RegisterUser::UsernameTakenError)
  end

end
