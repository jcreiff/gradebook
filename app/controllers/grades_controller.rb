class GradesController < ApplicationController
  before_action :set_grade, only: [:show, :edit, :update, :destroy]

  # GET /grades
  def index

    @students = Student.all.where(teacher_id: session[:teacher_id])
    @grades = []

    @students.each do |s|
      @grades += s.grades
    end
    
  end

  # GET /grades/1
  def show
  end

  # GET /grades/new
  def new
    @grade = Grade.new
    @students = Student.all.where(teacher_id: session[:teacher_id])
  end

  # GET /grades/1/edit
  def edit
    @students = Student.all.where(teacher_id: session[:teacher_id])
  end

  # POST /grades
  def create
    @student = Student.find_by_id(params[:id])
    @grade = Grade.new(grade_params)

    if @grade.save
      redirect_to @grade, notice: 'Grade was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /grades/1
  def update
    if @grade.update(grade_params)
      redirect_to @grade, notice: 'Grade was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /grades/1
  def destroy
    @grade.destroy
    redirect_to grades_url, notice: 'Grade was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def grade_params
      params.require(:grade).permit(:student_id, :assignment_name, :score, :date)
    end
end
