class InvoiceLine < ActiveRecord::Base
  belongs_to :invoice, inverse_of: :lines
end
