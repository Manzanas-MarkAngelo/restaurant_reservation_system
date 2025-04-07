class AdminDashboardController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admin
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

  def all_reservations
    # Filter reservations based on selected time period
    case params[:filter]
    when "today"
      @reservations = Reservation.includes(:user, :time_slot, table_assignment: :table)
                                  .joins(:time_slot)
                                  .where(time_slots: { date: Date.today })
                                  .order("time_slots.date ASC, time_slots.start_time ASC")
    when "this_week"
      start_of_week = Date.today.beginning_of_week
      end_of_week = Date.today.end_of_week
      @reservations = Reservation.includes(:user, :time_slot, table_assignment: :table)
                                  .joins(:time_slot)
                                  .where(time_slots: { date: start_of_week..end_of_week })
                                  .order("time_slots.date ASC, time_slots.start_time ASC")
    when "this_month"
      @reservations = Reservation.includes(:user, :time_slot, table_assignment: :table)
                                  .joins(:time_slot)
                                  .where(time_slots: { date: Date.today.beginning_of_month..Date.today.end_of_month })
                                  .order("time_slots.date ASC, time_slots.start_time ASC")
    else
      # Default to all reservations ordered by date and time
      @reservations = Reservation.includes(:user, :time_slot, table_assignment: :table)
                                  .joins(:time_slot)
                                  .order("time_slots.date ASC, time_slots.start_time ASC")
    end
  end

  def admin_cancel
    reservation = Reservation.find(params[:id])

    if reservation.user_id == current_user.id
      reservation.update(status: "Cancelled")
      reservation.table_assignment.update(is_reserved: false)
      flash[:notice] = "Reservation cancelled successfully."
    else
      flash[:alert] = "Unauthorized action."
    end

    redirect_to all_reservations_admin_dashboard_path
  end


  private

  def authenticate_admin!
    # Redirect to login if there's no admin logged in
    unless current_admin
      flash[:alert] = "Please log in to access the dashboard."
      redirect_to admin_login_path
    end
  end
  def set_admin
    @admin = current_admin
  end
end
