class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_action :check_teacher?
  # GET /assignments

  def index
    @assignments = Assignment.where(teacher_id: session[:teacher_id]).paginate(page: params[:page], per_page: 20)
  end

  # GET /assignments/1
  def show
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
    @assignment.grades.build
  end

  # POST /assignments
  def create
    @assignment = Assignment.new(assignment_params)

    if @assignment.save
      redirect_to edit_assignment_path(@assignment), notice: 'Assignment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /assignments/1
  def update
    if @assignment.update(assignment_params)
      respond_to do |format|
        format.html {redirect_to @assignment, notice: 'Assignment was successfully updated.'}
        format.js {redirect_to edit_assignment_path(@assignment), notice: 'Assignment was successfully updated.'}
      end
    else
      render :edit
    end
  end

  # DELETE /assignments/1
  def destroy
    @assignment.destroy
    redirect_to assignments_url, notice: 'Assignment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def assignment_params
      params.require(:assignment).permit(:name, :teacher_id, :date, grades_attributes:
        [:id, :assignment_id, :student_id, :score, :_destroy])
    end
end
