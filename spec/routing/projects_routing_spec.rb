require 'spec_helper'

describe ProjectsController do
  describe 'routing' do
    it 'routes to #index' do
      get('/projects').should route_to(controller: 'projects', action: 'index')
    end
  end
end
