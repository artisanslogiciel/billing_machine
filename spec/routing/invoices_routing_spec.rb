require 'spec_helper'

describe InvoicesController do
  describe 'routing' do
    it 'routes to #index' do
      get('/invoices').should route_to controller: 'invoices', action: 'index'
    end
  end
end
