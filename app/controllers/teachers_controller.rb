class TeachersController < ApplicationController
  before_action :set_teacher, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @teachers = Teacher.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @teacher = Teacher.new
  end

  # GET /users/1/edit
  def edit
  end

  private 

  def set_teacher
    @user = User.find(params[:id])
   @teacher =  @user.teachers.where(id: params[:id])
  end
  def teacher_params
    params.require(:teacher).permit(:name, :age, :kind, user_id)
  end

end
