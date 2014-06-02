class PaymentTerm < ActiveRecord::Base
  belongs_to :entity, inverse_of: :payment_terms
end
