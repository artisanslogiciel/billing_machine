class TimeSlice < ActiveRecord::Base
  validates :duration, presence: true, numericality: { less_than: 12, greater_than: 0 }

  belongs_to :activity
  belongs_to :user, inverse_of: :time_slices, dependent: :destroy
  belongs_to :project

  def self.to_csv(options = {:col_sep => ';'})
    CSV.generate(options) do |csv|
      column_names = ["Date", "Project", "Duration", "Activity", "Comment"]
      csv << column_names

      all.each do |time_slice|
        csv <<  [time_slice.day,
                 time_slice.project.name,
                 time_slice.duration,
                 time_slice.activity.label,
                 time_slice.comment]
      end
    end
  end

end
