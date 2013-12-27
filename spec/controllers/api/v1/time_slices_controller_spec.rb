require 'spec_helper'

module Api
  module V1
    describe TimeSlicesController do
      context 'when not authenticated' do
        describe '#index' do
          it 'should refuse access' do
            get :index, format: :json
            response.status.should_not eq(200)
          end
        end
        describe '#create' do
          it 'should refuse access' do
            post :create, format: :json, time_slice: FactoryGirl.attributes_for(:time_slice)
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

          it 'should sort time slices by date' do
            timeslice0 = FactoryGirl.create(:time_slice, day: Date.new(2013, 10, 1))
            timeslice1 = FactoryGirl.create(:time_slice, day: Date.new(2013,  9, 1))
            timeslice2 = FactoryGirl.create(:time_slice, day: Date.new(2013, 11, 1))
            get :index, format: :json
            assigns(:time_slices).should eq([timeslice2, timeslice0, timeslice1])
          end
        end

        describe '#create' do
          it 'should create an entry with valid params' do
            post :create, format: :json, time_slice: FactoryGirl.attributes_for(:time_slice)
            response.status.should eq(200)
          end

          it 'should create an entry with , instead of .' do
            post :create, format: :json, time_slice: FactoryGirl.attributes_for(:time_slice, duration: '4,2')
            response.status.should eq(200)
            assigns(:time_slice).duration.should eq(4.2)
          end

          it 'should evaluate durations' do
            post :create, format: :json, time_slice: FactoryGirl.attributes_for(:time_slice, duration: '=8/10')
            response.status.should eq(200)
            assigns(:time_slice).duration.should eq(0.8)
          end
        end
      end
    end
  end
end
