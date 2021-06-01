class Course < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  has_many :courses_groups
  has_many :groups, through: :courses_groups

  validates :name, length: { maximum: 55 }, presence: true, uniqueness: true
  validates :amount, presence: true

  def add_grouped_course(group_id)
    cg = CoursesGroup.where('group_id = ? AND course_id = ?', id, group_id).first
    result = true
    begin
      ActiveRecord::Base.transaction do
        cg.save!
      end
    rescue ActiveRecord::Rollback
      result = false
    end
    result
  end
end
