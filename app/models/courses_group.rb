class CoursesGroup < ApplicationRecord
  belongs_to :course
  belongs_to :group

  def self.create_courses_groups(course, group)
    begin
      ActiveRecord::Base.transaction do
        CoursesGroup.create!(course_id: course.id, group_id: group.id)

      end
    rescue ActiveRecord::Rollback
      return false
    end
    true
  end
end
