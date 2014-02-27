require 'spec_helper'

module Api
  module V1
    describe CustomersController do
      before(:each) do
        sign_in FactoryGirl.create :user
      end

      describe '#index' do
        it 'should grant access' do
          get :index, format: :json
          response.status.should eq(200)
        end
      end
    end
  end
end
