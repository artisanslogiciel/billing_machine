module Api
  module V1
    class InvoicesController < ApiController
      wrap_parameters include: [Invoice.attribute_names, :lines_attributes].flatten

      def index
        authorize! :read, Invoice
        render_invoice_list
      end

      def create
        authorize! :write, Invoice
        @invoice = Invoice.new(safe_params)
        @invoice.id_card = current_user.entity.current_id_card
        status = @invoice.save ? 200 : 422 
        if status == 200
          render partial: 'invoice', status: status, :locals => { :invoice => @invoice }
        else
          render json: '{"Invoice":["not saved"]}', status: status 
        end
      end

      def update
        @invoice = Invoice.find(params[:id])
        authorize! :write, @invoice
        status = @invoice.update(safe_params) ? 200 : 422
        if status == 200
          render partial: 'invoice', status: status, :locals => { :invoice => @invoice }
        else
          render json: '{"Invoice":["not saved"]}', status: status
        end
      end

      def show
        @invoice = Invoice.find(params[:id])
        authorize! :read, @invoice
        render partial: 'invoice', status: 200, :locals => { :invoice => @invoice }
      end

      private

        def safe_params
          safe_p = params.require(:invoice)
          safe_p.permit(:label, :paid, :customer_id, :date, :payment_term_id, :total_duty,
                        :vat, :total_all_taxes, :advance, :balance, :vat_rate,
                        :due_date,
                        lines_attributes: [:_destroy, :id, :label, :quantity,
                                           :unit, :unit_price, :total])
        end

        def render_invoice_list
          @invoices = current_user.entity.invoices.order(unique_index: :desc)
          respond_to do |format|
            format.csv { send_data generate_encoded_csv(@invoices), type: "text/csv" }
            format.json { respond_with @invoices }
          end
        end

        def generate_encoded_csv invoices # TODO extract to own class
          invoices.to_csv.encode("WINDOWS-1252", :crlf_newline => true , :invalid => :replace, :undef => :replace, :replace => "?")
        end
    end
  end
end
