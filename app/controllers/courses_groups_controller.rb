class CoursesGroupsController < ApplicationController
  def create
    row = { course_id: course.id, group_id: group.id}

    begin
      ActiveRecord::Base transaction do
        CoursesGroup.create!(row)
      end
      redirect_to courses_path, notice: 'Grouped course successfully created'
    rescue ActiveRecord::Rollback
      redirect_to courses_path, alert: 'Something went wrong, try again later'
    end
  end
end
