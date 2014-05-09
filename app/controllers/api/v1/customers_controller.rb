module Api
  module V1
    class CustomersController <  ApiController
      def index
        @customers = current_user.entity.customers
        respond_with @customers
      end
    end
  end
end
