class Group < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_and_belongs_to_many :courses, class_name: 'Course', foreign_key: 'course_id'
  validates :icon, uniqueness: true, allow_blank: true
  validates :name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 50 }
end
