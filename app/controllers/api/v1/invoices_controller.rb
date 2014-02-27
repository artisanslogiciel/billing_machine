module Api
  module V1
    class InvoicesController < ApiController
      wrap_parameters include: [Invoice.attribute_names, :lines_attributes].flatten
      
      def index
        @invoices = Invoice.all.order(date: :desc)
        respond_with @invoices
      end

      def create
        @invoice = Invoice.create(safe_params)
        status = @invoice.persisted? ? 200 : 422
        render partial: 'invoice', status: status, :locals => { :invoice => @invoice }
      end

      def update
        @invoice = Invoice.find(params[:id])
        status = @invoice.update(safe_params) ? 200 : 422 
        render partial: 'invoice', status: status, :locals => { :invoice => @invoice }
      end

      def show
        @invoice = Invoice.find(params[:id])
        render partial: 'invoice', status: 200, :locals => { :invoice => @invoice }
      end

      private

        def safe_params
          safe_p = params.require(:invoice)
          safe_p.permit(:label, :customer_id, :date, :payment_term_id, :total_duty,
                        :vat, :total_all_taxes, :advance, :balance, :entity_id, 
                        lines_attributes: [:_destroy, :id, :label, :quantity, :unit, :unit_price, :total])
        end
    end
  end
end
