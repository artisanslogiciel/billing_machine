module Api
  module V1
    class InvoicesController < ApiController
      wrap_parameters include: [Invoice.attribute_names, :lines_attributes].flatten

      def index
        begin
          authorize! :read, Invoice
          render_invoice_list
        rescue CanCan::AccessDenied => exeception
          render_forbidden_functionality_error
        end
      end

      def create
        authorize! :write, Invoice
        @invoice = Invoice.new(safe_params)
        @invoice.entity_id = current_user.entity_id
        status = @invoice.save ? 200 : 422
        render partial: 'invoice', status: status, :locals => { :invoice => @invoice }
      end

      def update
        @invoice = Invoice.find(params[:id])
        authorize! :write, @invoice
        status = @invoice.update(safe_params) ? 200 : 422
        render partial: 'invoice', status: status, :locals => { :invoice => @invoice }
      end

      def show
        @invoice = Invoice.find(params[:id])
        authorize! :read, @invoice
        render partial: 'invoice', status: 200, :locals => { :invoice => @invoice }
      end

      private

        def safe_params
          safe_p = params.require(:invoice)
          safe_p.permit(:label, :customer_id, :date, :payment_term_id, :total_duty,
                        :vat, :total_all_taxes, :advance, :balance, :vat_rate,
                        lines_attributes: [:_destroy, :id, :label, :quantity,
                                           :unit, :unit_price, :total])
        end

        def render_invoice_list
          @invoices = current_user.entity.invoices.order(unique_index: :desc)
          respond_with @invoices
        end
    end
  end
end
