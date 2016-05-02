class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_filter :is_admin?, only: [:index]

  def index
    @users = User.all
    respond_to do |format|
      format.html { render locals: { users: @users } }
      format.json { render json: users, status: 200 }
    end
  end

  def show
    respond_to do |format|
      format.html { render locals: { user: @user } }
      format.json { render json: @user }
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created, location: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to user_path(@user), flash: { notice: "#{@user.username} Updated!" } }
        format.json { render json: @user, status: :ok }
      end
      # render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :role, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
