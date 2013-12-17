class Activity < ActiveRecord::Base
  validates :label, presence: true, length: { minimum: 3 }
end
