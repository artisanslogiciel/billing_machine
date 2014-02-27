require 'spec_helper'

module Api
  module V1
    describe CustomersController do
      context 'when not authenticated' do
        describe '#index' do
          it 'should refuse access' do
            get :index
            response.status.should_not eq(200)
          end
        end
      end
            
      context 'when authenticated' do

        before(:each) do
          sign_in FactoryGirl.create :user
        end

        describe '#index' do
          it 'should grant access' do
            get :index, format: :json
            response.status.should eq(200)
          end
          it 'should only return currents user customers'
        end
      end
    end
  end
end
