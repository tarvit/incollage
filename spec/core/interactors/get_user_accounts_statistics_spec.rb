require 'spec_helper'

describe Incollage::GetUserAccountStatistics do
  let(:user) { TestFactories::UserFactory.create(id: 88) }

  before do |example|
    example.with_repos
    example.with_holders
  end

  subject { described_class.new(user.id).execute }

  context 'No Linked Accounts' do

    it 'should calculate user account statistics' do
      is_expected.to eq({
        accounts: [
            {
                :id => 1,
                :name => :test_account,
                :label => 'External Account',
                :linked_account_id => nil,
                :linked => false,
                linked_username: nil,
                collections: [
                    {
                        :id => 1,
                        :name => :test_collection,
                        :label => 'Test Collection',
                        :clippings_count => 0,
                    }
                ]
            }
        ]
      })
    end
  end

  context 'User has a Linked Account' do
    let(:external_account) { Incollage::Holder.for_external_accounts.added_accounts.first }
    let(:external_collection) { external_account.collections.first }
    let(:accounts_attrs) do
      {
          id: 99,
          user_id: user.id,
          external_account_id: external_account.id,
      }
    end
    let!(:linked_account) { TestFactories::LinkedAccountFactory.create(accounts_attrs) }

    it 'should calculate user account statistics with a linked account' do
      is_expected.to eq({
        accounts: [
           {
               :id => 1,
               :name => :test_account,
               :label => 'External Account',
               :linked_account_id => 99,
               :linked => true,
               linked_username: 'jdex',
               collections: [
                   {
                       :id => external_collection.id,
                       :name => :test_collection,
                       :label => 'Test Collection',
                       :clippings_count => 0,
                   }
               ]
           }
        ]
      })
    end

    context 'User has a synchronized Clippings within a Collection' do
      let :clipping_attrs do
        {
            user_id: user.id,
            external_id: external_account.id,
            collection_id: external_collection.id,
            linked_account_id: linked_account.id,
        }
      end

      let! :create_clippings do
        3.times { TestFactories::ClippingFactory.create(clipping_attrs) }
      end

      it 'should calculate user account statistics with Clippings synchronized' do
        is_expected.to eq({
           accounts: [
               {
                   :id => 1,
                   :name => :test_account,
                   :label => 'External Account',
                   :linked_account_id => 99,
                   :linked => true,
                   linked_username: 'jdex',
                   collections: [
                       {
                           :id => external_collection.id,
                           :name => :test_collection,
                           :label => 'Test Collection',
                           :clippings_count => 3,
                       }
                   ]
               }
           ]
        })
      end
    end
  end
end
