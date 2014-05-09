class InvoicesController < ApplicationController
  def index
    authorize! :read, Invoice
  end

  def show
    @invoice = Invoice.find(params[:id])
    authorize! :read, @invoice
    pdf = @invoice.pdf    
    send_data pdf.render, type: 'application/pdf',
          filename: "#{@invoice.tracking_id} #{@invoice.customer.short_name}.pdf", disposition: 'inline'
  end
end
