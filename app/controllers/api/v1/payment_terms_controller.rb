module Api
  module V1
    class PaymentTermsController <  ApiController
      def index
        respond_with payment_terms_of_current_user
      end

      def payment_terms_of_current_user
        PaymentTerm.where(entity_id: current_user.entity_id)
      end
    end
  end
end
