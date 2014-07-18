require 'spec_helper'

module Api
  module V1
    describe TimeSlicesController do
      JSON_RESPONSE_403 = '{"error":"You don\'t have access to this functionality"}'
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
            put :update, format: :json, id: another_time_slice.id, time_slice: {id: time_slice.id}

            assert_response :forbidden
            response.body.should == JSON_RESPONSE_403
          end
        end

        describe '#index' do

          it 'should grant access' do
            get :index, format: :json
            response.status.should eq(200)
          end

          it 'should sort time slices by date and updated_at' do
            timeslice0 = FactoryGirl.create(:time_slice, day: Date.new(2013, 10, 1), user: user)
            timeslice01 = FactoryGirl.create(:time_slice, day: Date.new(2013, 10, 1), user: user)
            timeslice02 = FactoryGirl.create(:time_slice, day: Date.new(2013, 10, 1), user: user)
            timeslice1 = FactoryGirl.create(:time_slice, day: Date.new(2013,  9, 1), user: user)
            timeslice2 = FactoryGirl.create(:time_slice, day: Date.new(2013, 11, 1), user: user)
            timeslice02.update(duration: 3)
            timeslice01.update(duration: 3)
            get :index, format: :json
            assigns(:time_slices).should eq([timeslice2, timeslice01, timeslice02, timeslice0, timeslice1])
          end

          it 'should return valid CSV' do
            time_slice_of_current_user = time_slice
            get :index, format: :csv
            CSV.parse(response.body)
          end

          it 'should return time_slice of current user in CSV' do
            time_slice_of_current_user = time_slice
            second_time_slice_of_current_user = FactoryGirl.create(:time_slice, user: user)
            time_slice_of_another_user = another_time_slice

            get :index, format: :csv

            assert_response :success
            number_of_time_slices_returned = CSV.parse(response.body).size - 1 # first line should be colums list
            number_of_time_slices_returned.should be == 2
          end

          it 'should only show the current users ts' do
            mine = FactoryGirl.create(:time_slice, user: user)
            FactoryGirl.create(:time_slice)
            get :index, format: :json
            assigns(:time_slices).should eq([mine])
          end

          it 'should check access rights' do
            user.update(time_machine: false)
            get :index, format: :json

            assert_response :forbidden
            response.body.should == JSON_RESPONSE_403
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

          context 'when invalid duration' do
            it 'should tell that the entity is not processable and why' do
              post :create, format: :json, time_slice: FactoryGirl.attributes_for(:time_slice, duration: nil)
              response.status.should eq(422)
              response.body.should == '{"duration":["can\'t be blank","is not a number"]}'
            end
          end

          context 'when duration is too long' do
            it 'should tell that the entity is not processable and why' do
              post :create, format: :json, time_slice: FactoryGirl.attributes_for(:time_slice, duration: '13')
              response.status.should eq(422)
              response.body.should == '{"duration":["must be less than 12"]}'
            end
          end

          context 'when invalid day' do
            it 'should tell that the entity is not processable and why' do
              post :create, format: :json, time_slice: FactoryGirl.attributes_for(:time_slice, day: 'I\'am not a date')
              response.status.should eq(422)
              response.body.should == '{"day":["can\'t be blank"]}'
            end
          end
          context 'when nothing is given' do
            it 'should tell that the entity is not processable and why' do
              post :create, format: :json, time_slice: nil
              response.status.should eq(422)
              response.body.should == '{"TimeSlice":["can\'t be empty"]}'
            end
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
            post :create, format: :json, time_slice: FactoryGirl.attributes_for(:time_slice)

            assert_response :forbidden
            response.body.should == JSON_RESPONSE_403
          end
        end
      end
    end
  end
end
