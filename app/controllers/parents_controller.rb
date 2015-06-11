class ParentsController < ApplicationController
  before_action :set_parent, only: [:show, :edit, :update, :destroy]

  # GET /parents
  def index
    @students = Student.all.where(teacher_id: session[:teacher_id])
    @parents = []

    @students.each do |s|
      @parents += s.parents
    end

  end

  # GET /parents/1
  def show
  end

  # GET /parents/new
  def new
    @parent = Parent.new
    @students = Student.all.where(teacher_id: session[:teacher_id])
  end

  # GET /parents/1/edit
  def edit
  end

  # POST /parents
  def create
    @student = Student.find_by_id(params[:student_id])
    @parent = Parent.new(parent_params)

    if @parent.save
      redirect_to @parent, notice: 'Parent was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /parents/1
  def update
    if @parent.update(parent_params)
      redirect_to @parent, notice: 'Parent was successfully updated.'
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
