class AddEntityIdToPaymentTerms < ActiveRecord::Migration
  def change
    add_reference :payment_terms, :entity, index: true
  end
end
