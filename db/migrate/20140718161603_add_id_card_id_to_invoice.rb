class AddIdCardIdToInvoice < ActiveRecord::Migration
  def change
    add_reference :invoices, :id_card, index: true
  end
end
