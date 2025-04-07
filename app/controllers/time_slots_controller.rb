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
      assign_tables_to_time_slot(@time_slot)
      redirect_to admin_dashboard_path, notice: "Time slot created and tables assigned successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @time_slot = TimeSlot.find(params[:id])
    old_max = @time_slot.max_tables

    # Parse start_time and calculate end_time
    if params[:time_slot][:start_time].present?
      start_time = Time.zone.parse(params[:time_slot][:start_time])
      params[:time_slot][:end_time] = (start_time + 1.hour).strftime("%H:%M")
    end

    if @time_slot.update(time_slot_params)
      if @time_slot.max_tables != old_max
        current_count = @time_slot.table_assignments.count
        difference = @time_slot.max_tables - current_count

        if difference > 0
          available_table_ids = Table.pluck(:id)
          difference.times do
            TableAssignment.create!(
              time_slot: @time_slot,
              table_id: available_table_ids.sample,
              max_persons: 2,
              is_available: true
            )
          end
        elsif difference < 0
          @time_slot.table_assignments.limit(difference.abs).destroy_all
        end
      end

      redirect_to admin_dashboard_path, notice: "Time slot updated."
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
    params.require(:time_slot).permit(:date, :start_time, :end_time, :max_tables, :is_active)
  end

  def active_tables
    table_assignments.where(is_active: true).count
  end

  def unreserved_tables
    table_assignments.where(is_reserved: false).count
  end


  def assign_tables_to_time_slot(time_slot)
    # Grab up to max_tables number of available tables
    available_tables = Table.limit(time_slot.max_tables)

    available_tables.each do |table|
      TableAssignment.create!(
        table: table,
        time_slot: time_slot,
        max_persons: 2,
        is_reserved: false,
        is_available: true
      )
    end
  end
end
