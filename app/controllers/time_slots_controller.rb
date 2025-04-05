class TimeSlotsController < ApplicationController
  def index
    selected_date = Date.parse(params[:date]) rescue nil
    if selected_date
      @time_slots = TimeSlot.where(date: selected_date, is_active: true).order(:start_time)
      render partial: "time_slots/modal", locals: { date: selected_date, time_slots: @time_slots }
    else
      head :bad_request
    end
  end
end
