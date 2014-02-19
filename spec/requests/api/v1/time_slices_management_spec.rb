require 'spec_helper'
require 'json'

describe 'Time Slices management' do
  before(:each) do
    @time_slice = FactoryGirl.create(:time_slice)
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
      end
    end

    describe '#create' do
      it 'returns the newly created item' do
        post '/api/v1/time_slices', time_slice: FactoryGirl.attributes_for(:time_slice)

        expect(json['id']).to eq(TimeSlice.last.id)
      end
    end

    describe '#update' do
      it 'returns the updated item' do
        new_duration = @time_slice.duration + 2

        put "/api/v1/time_slices/#{@time_slice.id}", time_slice: { duration: new_duration }

        expect(json['duration'].to_d).to eq(new_duration)
      end
    end
  end
end
