class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :following, :followers, :change_password]
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
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def change_password
    if @user.change_password(password: user_params[:new_password], password_confirmation: user_params[:new_password_confirmation])
      respond_to do |format|
        format.html { redirect_to user_path(@user), flash: { notice: "#{@user.username} successfully changed password" } }
        format.json { render json: @user, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to user_path(@user), flash: { error: "#{@user.username} failed to change password: #{@user.errors.full_messages.join(', ')}" } }
      end
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  def followers
    @user.followed
  end

  def following
    @user.following << Follower.new(followable_id: user_params[:followable_id], followable_type: user_params[:followable_type])
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :username,
      :role,
      :email,
      :password,
      :password_confirmation,
      :new_password,
      :new_password_confirmation,
      :followable_id,
      :followable_type
    )
  end

  def set_user
    @user = User.includes(:authentications).find(params[:id])
  end

end
