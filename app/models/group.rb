class Group < ApplicationRecord
  belongs_to :user

  has_many :courses, dependent: :destroy

  validates :icon, uniqueness: true, allow_blank: true
  validates :name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 20 }
end
