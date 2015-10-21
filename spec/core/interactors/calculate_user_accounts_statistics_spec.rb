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

  context 'User has a Linked Account' do

    before :each do
      @external_account = Incollage::Holder.for_external_accounts.added_accounts.first
      @linked_account = TestFactories::LinkedAccountFactory.create({
          id: 99,
          user_id: @user.id,
          external_account_id: @external_account.id,
      })
    end

    it 'should calculate user account statistics' do
      response = Incollage::CalculateUserAccountsStatistics.new(@user.id).execute
      expect(response).to eq({
        accounts: [
           {
               :external_account_id => 1,
               :external_account_name => :test_account,
               :external_account_label => 'External Account',
               :linked_account_id => 99,
               :linked => true,
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
