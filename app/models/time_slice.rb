class TimeSlice < ActiveRecord::Base
  validates :duration, presence: true, numericality: { less_than: 12, greater_than: 0 }
  validates :day, :presence => true

  belongs_to :activity
  belongs_to :user, inverse_of: :time_slices, dependent: :destroy
  belongs_to :project

  def self.to_csv(options = { :force_quotes => true, :col_sep => ";" })
    CSV.generate(options) do |csv|
      column_names = ["Date", "Project", "Duration", "Activity", "Comment", "Billing"]
      csv << column_names

      all.each do |time_slice|
        csv <<  [time_slice.try(:day),
                 time_slice.project.try(:name),
                 french_number(time_slice.duration),
                 time_slice.activity.try(:label),
                 time_slice.try(:comment),
                 time_slice.billable
                 ]
      end
    end
  end
  def self.french_number amount
     extend ActionView::Helpers::NumberHelper
     number_with_delimiter(amount, :delimiter => '', :separator => ",")
  end
end
