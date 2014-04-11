class TimeSlice < ActiveRecord::Base
  validates :duration, presence: true, numericality: { less_than: 12, greater_than: 0 }

  belongs_to :activity
  belongs_to :user, inverse_of: :time_slices, dependent: :destroy
  belongs_to :project
end
