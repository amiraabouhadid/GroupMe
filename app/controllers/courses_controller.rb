class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @courses = if params[:grouped]
                 current_user.courses.where.not(group_id: nil).includes(:group).all.order('created_at DESC')
               else
                 current_user.courses.where(group_id: nil).includes(:group).all.order('created_at DESC')
               end
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = current_user.courses.build
  end

  def edit; end

  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      redirect_to courses_path, notice: 'Course was successfully created.'
    else
      render :new, alert: 'Something went wrong try again.'
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_url, notice: 'Course was successfully destroyed.'
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :user_id, :amount, :group_id, :created_at)
  end
end
