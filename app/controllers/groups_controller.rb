class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  def index
    @groups = Group.order(:name)
  end

  def new
    @group = current_user.groups.build
  end

  def create
    user = User.find(current_user.id)
    @group = user.groups.build(group_params)

    if @group.save
      redirect_to @group
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :user_id, :icon)
  end
end
