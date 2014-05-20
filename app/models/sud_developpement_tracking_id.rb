class SudDeveloppementTrackingId

  def self.get_tracking_id(date, unique_index)
    if date
      date_without_dashes = date.strftime("%Y%m%d")
      "#{date_without_dashes}-#{unique_index}" # eg: 20140520-42
    else
      unique_index.to_s
    end
  end

end