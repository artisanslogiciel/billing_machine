class Customer < ActiveRecord::Base
  belongs_to :entity, inverse_of: :payment_terms
  validates_presence_of :entity
end
