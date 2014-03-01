# encoding: utf-8

class SudDeveloppementInvoice < Prawn::Document
  attr_accessor :invoice

  def initialize(invoice)
    super()
    @invoice = invoice
  end


  def build
    text 'FACTURE'
    
    text @invoice.customer.name
    text @invoice.customer.address1
    text @invoice.customer.address2
    text @invoice.customer.zip.to_s
    text @invoice.customer.city.to_s

    text 'Numéro de facture: '+ @invoice.tracking_id.to_s
    text 'Objet: '+ @invoice.label.to_s
    text 'Date: '+ @invoice.date.to_s
    text 'Terme de paiment: '+ @invoice.payment_term.label.to_s
    
    @invoice.lines.each do |line|
      add_line line
    end
    # if invoice.logo.exists?
    #   image @invoice.logo.path(:medium), at: [300, 730]
    #   # WIP Storing on Amazon
    #   # image open(@invoice.logo.url(:medium)), at: [300,730]
    # end

  end

  def add_line line
    text line.label

  end

  #   # create a bounding box for the list-item content
  #   bounding_box [25, cursor], width: 500 do
  #     text label
  #   end
  # end
end
