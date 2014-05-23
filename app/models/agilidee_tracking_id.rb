class AgilideeTrackingId

  def self.get_tracking_id(date, unique_index)
    if date
      year = date.strftime("%Y")
      year_on_two_digits = Integer(year) % 100
      "#{year_on_two_digits}#{unique_index}" # eg: 1442
    else
      unique_index.to_s
    end
  end

end