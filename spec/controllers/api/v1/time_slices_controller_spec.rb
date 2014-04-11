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
        let(:user) { FactoryGirl.create(:user) }
        let(:time_slice) { FactoryGirl.create(:time_slice, user: user) }
        let(:another_time_slice) { FactoryGirl.create(:time_slice) }

        before(:each) do
          sign_in user
        end

        describe '#update' do
          it 'should grant access if mine' do
            put :update, format: :json, id: time_slice.id, time_slice: {id: time_slice.id}
            response.status.should eq(200)
          end
          it 'should not grant access if not mine' do
            expect {
              put :update, format: :json, id: another_time_slice.id, time_slice: {id: time_slice.id}
              }.to raise_exception CanCan::AccessDenied            
          end
        end

        describe '#index' do

          it 'should grant access' do
            get :index, format: :json
            response.status.should eq(200)
          end

          it 'should sort time slices by date' do
            timeslice0 = FactoryGirl.create(:time_slice, day: Date.new(2013, 10, 1), user: user)
            timeslice1 = FactoryGirl.create(:time_slice, day: Date.new(2013,  9, 1), user: user)
            timeslice2 = FactoryGirl.create(:time_slice, day: Date.new(2013, 11, 1), user: user)
            get :index, format: :json
            assigns(:time_slices).should eq([timeslice2, timeslice0, timeslice1])
          end

          it 'should only show the current users ts' do
            mine = FactoryGirl.create(:time_slice, user: user)
            FactoryGirl.create(:time_slice)
            get :index, format: :json
            assigns(:time_slices).should eq([mine])
          end

          it 'should check access rights' do
            user.update(time_machine: false)
            expect {
              get :index, format: :json
              }.to raise_exception CanCan::AccessDenied       
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

          it 'should assign current user as owner' do
            post :create, format: :json, time_slice: FactoryGirl.attributes_for(:time_slice)
            response.status.should eq(200)
            assigns(:time_slice).user.should eq(user)
          end

          it 'should evaluate durations' do
            post :create, format: :json, time_slice: FactoryGirl.attributes_for(:time_slice, duration: '=8/10')
            response.status.should eq(200)
            assigns(:time_slice).duration.should eq(0.8)
          end
           it 'should check access rights' do
              user.update(time_machine: false)
              expect {
                post :create, format: :json, time_slice: FactoryGirl.attributes_for(:time_slice)
                }.to raise_exception CanCan::AccessDenied       
          end
        end
      end
    end
  end
end
