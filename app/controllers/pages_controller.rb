class PagesController < ApplicationController
  def home
    @start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
    @previous_month = @start_date.prev_month.beginning_of_month
    @next_month = @start_date.next_month.beginning_of_month

    # Get the full date range shown on the calendar (safety window around month)
    range_start = @start_date.beginning_of_month.beginning_of_week
    range_end = @start_date.end_of_month.end_of_week

    # Load all active time slots within the visible calendar range
    @available_dates = TimeSlot.where(date: range_start..range_end).distinct.pluck(:date)
  end
end
