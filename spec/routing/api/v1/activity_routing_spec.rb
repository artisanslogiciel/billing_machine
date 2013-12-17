require 'spec_helper'

module Api
  module V1
    describe ActivitiesController do
      describe 'routing' do
        it 'routes to #index' do
          get('/api/v1/activities').should route_to(controller: 'api/v1/activities', action: 'index', format: 'json')
        end
      end
    end
  end
end
