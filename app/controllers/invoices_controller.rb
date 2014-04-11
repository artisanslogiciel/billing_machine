class InvoicesController < ApplicationController
  def show
    @invoice = Invoice.find(params[:id])
    authorize! :read, @invoice
    pdf = SudDeveloppementInvoice.new(@invoice)
    pdf.build
    send_data pdf.render, type: 'application/pdf',
          filename: "#{@invoice.tracking_id} #{@invoice.customer.short_name}.pdf", disposition: 'inline'
  end
end
