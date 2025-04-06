class TableAssignmentsController < ApplicationController
  before_action :set_table_assignment, only: [ :show, :edit, :update, :destroy ]

  # GET /table_assignments
  def index
    if params[:time_slot_id].present?
      @table_assignments = TableAssignment.where(time_slot_id: params[:time_slot_id])
    else
      @table_assignments = TableAssignment.all
    end
  end

  # GET /table_assignments/:id
  def show
  end

  # GET /table_assignments/new
  def new
    @table_assignment = TableAssignment.new
  end

  # POST /table_assignments
  def create
    @table_assignment = TableAssignment.new(table_assignment_params)

    if @table_assignment.save
      redirect_to @table_assignment, notice: "Table assignment was successfully created."
    else
      render :new
    end
  end

  # GET /table_assignments/:id/edit
  def edit
  end

  # PATCH/PUT /table_assignments/:id
  def update
    if @table_assignment.update(table_assignment_params)
      redirect_to table_assignments_path, notice: "Table assignment was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /table_assignments/:id
  def destroy
    @table_assignment.destroy
    redirect_to table_assignments_url, notice: "Table assignment was successfully destroyed."
  end

  private
    def set_table_assignment
      @table_assignment = TableAssignment.find(params[:id])
    end

    def table_assignment_params
      params.require(:table_assignment).permit(:table_id, :time_slot_id, :max_persons, :is_reserved, :is_available)
    end
end
