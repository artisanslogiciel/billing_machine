require 'spec_helper'

module Api
  module V1
    describe PaymentTermsController do
      describe 'routing' do
        it 'routes to #index' do
          get('/api/v1/payment_terms').should route_to(controller: 'api/v1/payment_terms', action: 'index', format: 'json')
        end
      end
    end
  end
end
