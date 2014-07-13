require 'spec_helper'
require 'json'

describe 'Time Slices management' do
  before(:each) do
    @user = FactoryGirl.create :user
    @time_slice = FactoryGirl.create(:time_slice, user: @user, billable: true)
  end

  context 'when not authenticated' do
    describe '#index' do
      it 'refuses access' do
        get '/api/v1/time_slices'
        expect(response.status).to_not eq(200)
      end
    end
  end

  context 'when authenticated' do
    before(:each) do
      sign_in_as_a_valid_user
    end
    describe '#index' do
      it 'returns all items' do
        get '/api/v1/time_slices'

        expect(json.size).to eq(1)
        expect(json[0]['id']).to eq(@time_slice.id)
        expect(json[0]['billable']).to eq(true)
        expect(json[0]['activity']['id']).to eq(@time_slice.activity.id)
        expect(json[0]['activity']['label']).to eq(@time_slice.activity.label)
        expect(json[0]['project']['id']).to eq(@time_slice.project.id)
        expect(json[0]['project']['name']).to eq(@time_slice.project.name)
      end
    end

    describe '#create' do
      it 'returns the newly created item' do
        post '/api/v1/time_slices', time_slice: FactoryGirl.attributes_for(:time_slice, billable: true)

        expect(json['id']).to eq(TimeSlice.last.id)
        expect(json['billable']).to eq(true)
      end
    end

    describe '#update' do
      it 'returns the updated item' do
        new_duration = @time_slice.duration + 2

        put "/api/v1/time_slices/#{@time_slice.id}", time_slice: { duration: new_duration }

        expect(json['duration'].to_d).to eq(new_duration)
        expect(json['billable']).to eq(true)
      end
    end
  end
end
