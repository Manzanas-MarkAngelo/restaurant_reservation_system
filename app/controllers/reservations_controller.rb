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
  end
end
