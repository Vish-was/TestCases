class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    
    if @user.kind == "Teacher" && @user.enrollments.any?
      flash[:error] = "Kind cannot be student because is teaching in at least one program"
      render :edit
    elsif @user.kind == "Student" && @user.enrollments.any?
      flash[:error] = "Kind cannot be teacher because is studying in at least one program"
      render :edit
    else
      update_user
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def update_user
    if @user.update(user_params)
      flash[:success] = "User updated successfully."
      redirect_to @user
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:name, :age, :kind)
  end
end
