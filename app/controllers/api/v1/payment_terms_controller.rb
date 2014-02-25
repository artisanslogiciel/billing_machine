module Api
  module V1
    class PaymentTermsController <  ApiController
      def index
        respond_with PaymentTerm.all
      end
    end
  end
end
