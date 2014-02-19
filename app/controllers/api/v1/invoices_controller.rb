module Api
  module V1
    class InvoicesController < ApiController
      def index
        @invoices = Invoice.all.order(date: :desc)
        respond_with @invoices
      end

      def create
        @invoice = Invoice.create(safe_params)
        render :show
      end

      def update
        @invoice = Invoice.find(params[:id])
        @invoice.update(safe_params)
        render :show
      end

      private

        def safe_params
          safe_p = params.require(:invoice)
          safe_p.permit(:label, :customer_id, :date, :payment_term_id, :total_duty,
                        :vat, :total_all_taxes, :advance, :balance, :entity_id)
        end
    end
  end
end
