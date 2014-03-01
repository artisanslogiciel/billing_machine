require 'spec_helper'

describe InvoicesController do
  describe 'routing' do
    it 'routes to #index' do
      get('/invoices').should route_to controller: 'invoices', action: 'index'
    end
    it 'routes to #show pdf' do
      get('/invoices/1.pdf').should route_to controller: 'invoices', action: 'show', format: 'pdf', id: "1"
    end
  end
end
