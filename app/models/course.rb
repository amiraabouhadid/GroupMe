class Course < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  validates :name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 20 }
  validates :amount, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 1000.0 }
end
