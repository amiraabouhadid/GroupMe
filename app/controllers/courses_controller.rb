class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @courses = if params['ungrouped']
                 Course.where(author: current_user).includes(:courses_groups).where(courses_groups: { id: nil }).includes([:groups])
               else
                 Course.where(author: current_user).includes(:courses_groups).where.not(courses_groups: { id: nil })
               end
    @user = User.find(current_user.id)
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    if request.original_url.include?('groups')
      @group = Group.find(params[:group_id])
      @course = @group.courses.new
    else
      @course = Course.new
    end
  end

  def create
    if request.original_url.include?('groups')
      @group = Group.find(params[:group_id])
      @course = Course.create(course_params)
      @course.groups << @group
    else
      @course = Course.create(course_params)
    end
    @course.author = current_user
    if @course.save
      notice = 'Course successfully saved'
      if request.original_url.include?('groups')
        redirect_to @group
      else
        redirect_to @course
      end
    else
      render :new
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :author, :amount, :group, :created_at)
  end
end
