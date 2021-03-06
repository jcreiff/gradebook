class ParentsController < ApplicationController
  before_action :set_parent, only: [:show, :edit, :update, :destroy]
  before_action :check_teacher?, except: [:show, :edit]

  # GET /parents
  def index
    @parents = Parent.joins(:student).where(students: {teacher_id: session[:teacher_id]}).paginate(page: params[:page], per_page: 20)
  end

  # GET /parents/1
  def show
    @parent = Parent.find_by_id(params[:id])

    if session[:teacher_id]
      @students = Student.all.where(teacher_id: session[:teacher_id])
    else
      redirect_to root_path, notice: 'Access Denied' unless @parent.id == session[:parent_id]
    end

  end

  # GET /parents/new
  def new
    @parent = Parent.new
    @students = Student.all.where(teacher_id: session[:teacher_id])
  end

  # GET /parents/1/edit
  def edit
    @parent = Parent.find_by_id(params[:id])

    if session[:teacher_id]
      @students = Student.all.where(teacher_id: session[:teacher_id])
    else
      redirect_to root_path, notice: 'Access Denied' unless @parent.id == session[:parent_id]
    end

  end

  # POST /parents
  def create
    @student = Student.find_by_id(params[:student_id])
    @parent = Parent.new(parent_params)

    if @parent.save
      redirect_to parents_path, notice: 'Parent was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /parents/1
  def update
    if @parent.update(parent_params)
      redirect_to parents_path, notice: 'Parent was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /parents/1
  def destroy
    @parent.destroy
    redirect_to parents_url, notice: 'Parent was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parent
      @parent = Parent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def parent_params
      params.require(:parent).permit(:student_id, :name, :email, :password, :password_confirmation)
    end
end
