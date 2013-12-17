require 'spec_helper'

module Api
  module V1
    describe TimeSlicesController do
      describe 'routing' do
        it 'routes to #index' do
          get('/api/v1/time_slices').should route_to(controller: 'api/v1/time_slices', action: 'index', format: 'json')
        end
        it 'routes to #create' do
          post('/api/v1/time_slices').should route_to(controller: 'api/v1/time_slices', action: 'create', format: 'json')
        end
        it 'routes to #update' do
          put('/api/v1/time_slices/1').should route_to(controller: 'api/v1/time_slices', action: 'update', format: 'json', id: '1')
        end
      end
    end
  end
end
