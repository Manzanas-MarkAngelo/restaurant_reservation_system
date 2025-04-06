class TimeSlotsController < ApplicationController
  before_action :set_time_slot, only: [ :edit, :update, :destroy ]

  def index
    selected_date = Date.parse(params[:date]) rescue nil
    if selected_date
      @time_slots = TimeSlot.where(date: selected_date, is_active: true).order(:start_time)
      render partial: "time_slots/modal", locals: { date: selected_date, time_slots: @time_slots }
    else
      head :bad_request
    end
  end

  def new
    @time_slot = TimeSlot.new
    @date = params[:date] # Passed from the previous page
    @hours = (0..23).to_a # Time range from 0 to 23 (24-hour format)
  end

  def create
    @time_slot = TimeSlot.new(time_slot_params)
    @time_slot.is_active = true

    # Set the end time to 1 hour after the selected start time
    if @time_slot.start_time.present?
      @time_slot.end_time = @time_slot.start_time + 1.hour
    end

    if @time_slot.save
      redirect_to admin_dashboard_path, notice: "Time slot created successfully."
    else
      # If the model is not valid, render the new form again and show errors
      render :new, status: :unprocessable_entity
    end
  end


  def edit
  end

  def update
    if @time_slot.update(time_slot_params)
      redirect_to admin_dashboard_path, notice: "Time slot updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @time_slot.destroy
    redirect_to admin_dashboard_path, notice: "Time slot deleted."
  end

  private

  def set_time_slot
    @time_slot = TimeSlot.find(params[:id])
  end

  def time_slot_params
    params.require(:time_slot).permit(:date, :start_time, :end_time, :is_active, :max_tables)
  end

  def active_tables
    table_assignments.where(is_active: true).count
  end
end
