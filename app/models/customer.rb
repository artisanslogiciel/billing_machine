class Customer < ActiveRecord::Base
  belongs_to :entity, inverse_of: :customers
  validates_presence_of :entity

   default_scope{order('name')}
end
