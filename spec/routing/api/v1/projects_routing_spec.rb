require 'spec_helper'

module Api
  module V1
    describe ProjectsController do
      describe 'routing' do
        it 'routes to #index' do
          get('/api/v1/projects').should route_to(controller: 'api/v1/projects', action: 'index', format: 'json')
        end
        it 'routes to #create' do
          post('/api/v1/projects').should route_to(controller: 'api/v1/projects', action: 'create', format: 'json')
        end
        it 'routes to #update' do
          put('/api/v1/projects/1').should route_to(controller: 'api/v1/projects', action: 'update', format: 'json', id: '1')
        end
      end
    end
  end
end
