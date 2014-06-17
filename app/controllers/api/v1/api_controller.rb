module Api
  module V1
    class ApiController <  ActionController::Base
      before_filter :authenticate_user!
      respond_to :json

      rescue_from CanCan::AccessDenied do
        render_forbidden_functionality_error
      end

      def render_forbidden_functionality_error
          json_content = '{"error":"You don\'t have access to this functionality"}'
          render json: json_content, status: :forbidden
      end
    end
  end
end
