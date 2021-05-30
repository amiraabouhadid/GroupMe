class Group < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :courses

  validates :icon, url: { allow_blank: true }
  validates :name, presence: true, uniqueness: true
end
