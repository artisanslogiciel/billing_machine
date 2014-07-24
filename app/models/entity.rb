##
# This class represents an intitution to which a User or a Customer or
# an Invoice belongs to.
#
# The boolean attributes billing_machine and time_machine define if the *users*
# attached to the Entity can access thoses modules
# (each User have similar attributes to manage individual permissions).
class Entity < ActiveRecord::Base
  has_many :projects, inverse_of: :entity, dependent: :destroy
  has_many :id_cards, inverse_of: :entity, dependent: :destroy
  has_many :invoices, through: :id_cards , dependent: :destroy
  has_many :payment_terms, inverse_of: :entity, dependent: :destroy
  has_many :customers, inverse_of: :entity, dependent: :destroy
  validates_presence_of :customization_prefix

  def current_id_card
    IdCard.find(self.current_id_card_id)
  end

end
