class TimeSlice < ActiveRecord::Base
  validates :duration, presence: true, numericality: { less_than: 12, greater_than: 0 }

  belongs_to :activity
  belongs_to :user, inverse_of: :time_slices, dependent: :destroy
  belongs_to :project



  def self.to_csv(options = {:col_sep => ';'})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |time_slice|
        csv << time_slice.attributes.values_at(*column_names)
      end
    end
  end

end
