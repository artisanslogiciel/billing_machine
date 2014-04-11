class TimeSlicesController < ApplicationController
  def index
    authorize! :read, TimeSlice
  end
end
