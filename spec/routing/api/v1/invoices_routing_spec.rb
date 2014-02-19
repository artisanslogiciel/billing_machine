require 'spec_helper'

module Api
  module V1
    describe InvoicesController do
      describe 'routing' do
        it 'routes to #index' do
          get('/api/v1/invoices').should route_to(controller: 'api/v1/invoices', action: 'index', format: 'json')
        end
        it 'routes to #create' do
          post('/api/v1/invoices').should route_to(controller: 'api/v1/invoices', action: 'create', format: 'json')
        end
        it 'routes to #update' do
          put('/api/v1/invoices/1').should route_to(controller: 'api/v1/invoices', action: 'update', format: 'json', id: '1')
        end
      end
    end
  end
end
