require 'spec_helper'

describe Incollage::CalculateUserAccountsStatistics do

  before :each do
    @user = TestFactories::UserFactory.create(id: 88)
  end

  context 'No Linked Accounts' do

    it 'should calculate user account statistics' do
      response = Incollage::CalculateUserAccountsStatistics.new(@user.id).execute
      expect(response).to eq({
        external_accounts: [
            {
                :external_account_id => 1,
                :external_account_name => :test_account,
                :external_account_label => 'External Account',
                :linked_account_id => nil,
                :linked => false,
            }
        ]
      })
    end

  end

end
