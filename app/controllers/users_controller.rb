class UsersController < ApplicationController
  before_action :authenticate_user!
  def index; end

  def show
    @user = User.find(current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      notice = 'Signed Up successfully'
      redirect_to @user
    else
      alert = 'Something went wroong, try again later'
      redirect_to new_user_session_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
