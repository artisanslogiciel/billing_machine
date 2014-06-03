module Api
  module V1
    class PaymentTermsController <  ApiController
      def index
        respond_with PaymentTerm.where(entity_id: current_user.entity_id)
      end
    end
  end
end
