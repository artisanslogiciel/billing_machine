require 'spec_helper'

describe TimeSlicesController do
  describe 'routing' do
    it 'routes to #index' do
      get('/time_slices').should route_to(controller: 'time_slices', action: 'index')
    end
  end
end
