class Course < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_and_belongs_to_many :groups, optional: true

  validates :name, length: { maximum: 55 }, presence: true, uniqueness: true
  validates :amount, presence: true
end
