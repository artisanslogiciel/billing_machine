class InvoiceLine < ActiveRecord::Base
  belongs_to :invoice, inverse_of: :lines
  default_scope{order('created_at asc')}
end
