class AdminDashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    @admin = current_admin
    @start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
    @previous_month = @start_date.prev_month.beginning_of_month
    @next_month = @start_date.next_month.beginning_of_month

    # Get the full date range shown on the calendar (safety window around month)
    range_start = @start_date.beginning_of_month.beginning_of_week
    range_end = @start_date.end_of_month.end_of_week

    # Load all active time slots within the visible calendar range
    @available_dates = TimeSlot.where(date: range_start..range_end).distinct.pluck(:date)
  end

  private

  def authenticate_admin!
    # Redirect to login if there's no admin logged in
    unless current_admin
      flash[:alert] = "Please log in to access the dashboard."
      redirect_to admin_login_path
    end
  end
end
