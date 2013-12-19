module Api
  module V1
    class ApiController <  ActionController::Base
      before_filter :authenticate_user!
      respond_to :json
    end
  end
end
