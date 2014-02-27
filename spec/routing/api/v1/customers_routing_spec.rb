require 'spec_helper'

module Api
  module V1
    describe CustomersController do
      describe 'routing' do
        it 'routes to #index' do
          get('/api/v1/customers').should route_to(controller: 'api/v1/customers', action: 'index', format: 'json')
        end
      end
    end
  end
end
