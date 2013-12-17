require 'spec_helper'

describe 'Activities' do
  before(:each) do
    @activity = FactoryGirl.create(:activity)
  end
  describe '#index' do
    it 'returns all acitivities' do
      get '/api/v1/activities'

      expect(json.size).to eq(1)
      expect(json[0]['label']).to eq(@activity.label)
    end
  end
end
