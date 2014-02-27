require 'spec_helper'

describe 'Activities' do
  before(:each) do
    @activity = FactoryGirl.create(:activity)
  end
  context 'when not authenticated' do
    describe '#index' do
      it 'refuses access' do
        get '/api/v1/activities'
        expect(response.status).to_not eq(200)
      end
    end
  end

  context 'when authenticated' do
    before(:each) do
      sign_in_as_a_valid_user
    end

    describe '#index' do
      it 'returns status 200' do
        get '/api/v1/activities'
        expect(response.status).to eq(200)
      end
    end
  end
end
