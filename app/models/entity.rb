class Entity < ActiveRecord::Base
  has_many :invoices, inverse_of: :entity, dependent: :destroy
end
