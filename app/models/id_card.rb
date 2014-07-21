class IdCard < ActiveRecord::Base
  belongs_to :entity, inverse_of: :id_cards
  has_many :invoices, inverse_of: :id_card
  validates_presence_of :entity
end
