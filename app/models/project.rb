class Project < ActiveRecord::Base
  belongs_to :entity, inverse_of: :projects
  validates_presence_of :entity
  validates :name, presence: true, length: { minimum: 3 }
end
