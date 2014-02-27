class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :payment_term
  belongs_to :entity
  has_many :lines,  inverse_of: :invoice, dependent: :destroy, class_name: 'InvoiceLine'
  accepts_nested_attributes_for :lines, allow_destroy: true
end
