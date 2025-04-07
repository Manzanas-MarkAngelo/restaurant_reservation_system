class ReservationsController < ApplicationController
  def index
    selected_date = Date.parse(params[:date]) rescue nil
    if selected_date
      @time_slots = TimeSlot.where(date: selected_date, is_active: true).order(:start_time)
      render partial: "reservations/modal_user", locals: { date: selected_date, time_slots: @time_slots }
    else
      head :bad_request
    end
  end

  def new
    @time_slot = TimeSlot.find_by(id: params[:time_slot_id])
    if @time_slot
      @table_assignments = @time_slot.table_assignments.includes(:table)
    else
      redirect_to root_path, alert: "Invalid time slot"
    end
  end

  def form
    @table_assignment = TableAssignment.find(params[:id])
    @time_slot = @table_assignment.time_slot
    @user = current_user
  end

  def create
    reservation = Reservation.new(
      party_size: params[:party_size],
      time_slot_id: params[:time_slot_id],
      table_assignment_id: params[:table_assignment_id],
      user_id: current_user.id
    )

    if reservation.save
      flash[:notice] = "Reservation successfully created!"
      redirect_to root_path
    else
      flash[:alert] = reservation.errors.full_messages.join(", ")
      redirect_back fallback_location: root_path
    end
  end

  def my_reservations
    @reservations = current_user.reservations.includes(:time_slot, :table_assignment)
  end
  def show
    @reservation = Reservation.find(params[:id])
  end

  def cancel
    reservation = Reservation.find(params[:id])

    if reservation.user_id == current_user.id
      reservation.update(status: "Cancelled")
      reservation.table_assignment.update(is_reserved: false)
      flash[:notice] = "Reservation cancelled successfully."
    else
      flash[:alert] = "Unauthorized action."
    end

    redirect_to my_reservations_reservations_path
  end


  def admin_cancel
    reservation = Reservation.find(params[:id])

    # No need to check reservation.user_id against current user
    reservation.update(status: "Cancelled")
    reservation.table_assignment.update(is_reserved: false)
    flash[:notice] = "Reservation cancelled successfully."

    redirect_to admin_all_reservations_path
  end
end
