class TablesController < ApplicationController
  before_action :set_table_assignment, only: [ :edit, :update ]
  def index
    @table_assignments = TableAssignment.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    if @table_assignment.update(table_assignment_params)
      redirect_to tables_path, notice: "Table assignment updated successfully."
    else
      render :edit
    end
  end

  private

  def set_table_assignment
    @table_assignment = TableAssignment.find(params[:id])
  end

  def table_assignment_params
    params.require(:table_assignment).permit(:max_persons, :is_available)
  end
end
