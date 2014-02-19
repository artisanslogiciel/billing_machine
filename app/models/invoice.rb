class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :payment_term
  belongs_to :entity
end
