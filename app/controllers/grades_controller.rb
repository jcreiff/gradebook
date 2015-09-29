class GradesController < ApplicationController
  before_action :set_grade, only: [:show, :edit, :update, :destroy]
  before_action :check_teacher?, except: [:index, :show]
  # GET /grades
  def index
    if session[:teacher_id]
      @grades = Grade.joins(:student).where(students: {teacher_id: session[:teacher_id]}).paginate(page: params[:page], per_page: 20)
    elsif session[:student_id]
      @grades = Grade.all.where(student_id: session[:student_id]).paginate(page: params[:page], per_page: 20)
    else
      @parent = Parent.find_by_id(session[:parent_id])
      @grades = Grade.all.where(student_id: @parent.student_id).paginate(page: params[:page], per_page: 20)
    end
  end

  # GET /grades/1
  def show
    @grade = Grade.find_by_id(params[:id])
    if session[:student_id]
      redirect_to root_path, notice: 'Access Denied' unless @grade.student_id == session[:student_id]
    elsif session[:parent_id]
      redirect_to root_path, notice: 'Access Denied' unless  @grade.student.parents.first.id == session[:parent_id]
    end
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
