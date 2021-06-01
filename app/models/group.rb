class Group < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :courses_groups
  has_many :courses, through: :courses_groups

  validates :icon, uniqueness: true, allow_blank: true
  validates :name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 50 }
end
