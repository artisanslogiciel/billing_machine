module Api
  module V1
    class ApiController <  ActionController::Base
      require 'csv'
      before_filter :authenticate_user!
      respond_to :json
    end
  end
end
