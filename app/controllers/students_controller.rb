class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :check_teacher?, except: [:show, :edit]
  # GET /students
  def index
    @students = Student.where(teacher_id: session[:teacher_id])
  end

  # GET /students/1
  def show
    @student = Student.find_by_id(params[:id])
    @parents = Parent.where(student_id: @student.id)
    @grades = Grade.where(student_id: @student.id)
    if !(session[:teacher_id])
      redirect_to root_path, notice: 'Access Denied' unless @student.id == session[:student_id]
    end
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
    @student = Student.find_by_id(params[:id])
    if !(session[:teacher_id])
      redirect_to root_path, notice: 'Access Denied' unless @student.id == session[:student_id]
    end
  end

  # POST /students
  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to @student, notice: 'Student was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /students/1
  def update
    if @student.update(student_params)
      redirect_to @student, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /students/1
  def destroy
    @student.destroy
    redirect_to students_url, notice: 'Student was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def student_params
      params.require(:student).permit(:teacher_id, :name, :email, :password, :password_confirmation)
    end
end
