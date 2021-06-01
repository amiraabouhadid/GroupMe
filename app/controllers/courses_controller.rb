class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @courses = if params[:grouped]
                 Course.where(author: current_user).includes(:courses_groups).where.not(courses_groups: { id: nil })
               else
                 Course.where(author: current_user).includes(:courses_groups).where(courses_groups: { id: nil }).includes([:groups])
               end
    @grouped_courses = Course.where(author: current_user).includes(:courses_groups).where.not(courses_groups: { id: nil })
    @ungrouped_courses = Course.where(author: current_user).includes(:courses_groups).where(courses_groups: { id: nil }).includes([:groups])
    @user = User.find(current_user.id)
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @grouped_courses = Course.where(author: current_user).includes(:courses_groups).where.not(courses_groups: { id: nil })
    @ungrouped_courses = Course.where(author: current_user).includes(:courses_groups).where(courses_groups: { id: nil }).includes([:groups])

    if request.referrer.to_s.include?('/courses?grouped=true')
      @group = Group.find(params[:id])
      debugger

      @course = @group.courses.build

    else
      @course = Course.new
    end
  end

  def create
    if request.referrer.to_s.include?('/courses?grouped=true')
      @group = Group.find_by(id: params[:group_id])
      @course = Course.create(course_params)
      @course.groups << @group
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

  def course_params
    params.require(:course).permit(:name, :author, :amount, :group_id, :created_at)
  end
end
