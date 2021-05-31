class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @courses = if params[:grouped]
                 Course.where(author: current_user).includes(:courses_groups).where.not(courses_groups: { id: nil })
               else
                 Course.where(author: current_user).includes(:courses_groups).where(courses_groups: { id: nil }).includes([:groups])
               end

    @user = User.find(current_user.id)
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    if request.referrer.to_s.include?('/courses?grouped=true')
      @groupedcourses = Group.find(group_params)
      @course = @groupedcourses.courses.new
    else
      @course = Course.new
    end
  end

  def create
    if request.referrer.to_s.include?('/courses?grouped=true')
      @groupedcourses = Group.find(group_params)
      @course = Course.create(course_params)
      @course.groups << @groupedcourses
    else
      @course = Course.create(course_params)
    end
    @course.author = current_user
    if @course.save
      notice = 'Course successfully saved'
      if request.referrer.to_s.include?('/courses?grouped=true')
        redirect_to @group
      else
        redirect_to @course
      end
    else
      redirect_to courses_path
      alert = 'Something went wrong, please try again later'
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :icon, :created_at)
  end

  def course_params
    params.require(:course).permit(:name, :author, :amount, :group_id, :created_at)
  end
end
