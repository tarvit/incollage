require 'spec_helper'

describe Incollage::CalculateUserAccountsStatistics do

  before :each do
    @user = TestFactories::UserFactory.create(id: 88)
  end

  context 'No Linked Accounts' do

    it 'should calculate user account statistics' do
      response = Incollage::CalculateUserAccountsStatistics.new(@user.id).execute
      expect(response).to eq({
        accounts: [
            {
                :external_account_id => 1,
                :external_account_name => :test_account,
                :external_account_label => 'External Account',
                :linked_account_id => nil,
                :linked => false,
                collections: [
                    {
                        :external_collection_id => 1,
                        :external_collection_name => :test_collection,
                        :external_collection_label => 'Test Collection',
                        :clippings_count => 0,
                    }
                ]
            }
        ]
      })
    end

  end

end
