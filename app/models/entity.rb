##
# This class represents an intitution to which a User or a Customer or
# an Invoice belongs to.
#
# The boolean attributes billing_machine and time_machine define if the *users*
# attached to the Entity can access thoses modules
# (each User have similar attributes to manage individual permissions).
class Entity < ActiveRecord::Base
  has_many :invoices, inverse_of: :entity, dependent: :destroy
end
