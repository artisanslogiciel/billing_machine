require 'spec_helper'

module Api
  module V1
    describe PaymentTermsController do
      before(:each) do
        sign_in @user = FactoryGirl.create(:user)
      end

      describe '#index' do
        it 'should grant access' do
          get :index, format: :json
          response.status.should eq(200)
        end
        it 'should only show payment terms from the same entity as the user' do
          # create 3 terms(with same entity, other entity, nil)
          other_entity = FactoryGirl.create :entity
          FactoryGirl.create :payment_term, entity: @user.entity
          FactoryGirl.create :payment_term, entity: other_entity
          FactoryGirl.create :payment_term, entity: nil

          get :index, format: :json
          payment_terms = JSON.parse(response.body, symbolize_names: true)
          # collect all the entity_id with no duplicates
          entity_id_list = (payment_terms.collect { |term| term[:entity_id] }).uniq
          # it should remain only one id and it should be the one of the user
          entity_id_list.should == [@user.entity_id]
        end
      end
    end
  end
end
