class Group < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_and_belongs_to_many :courses
  validates :name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 50 }
end
