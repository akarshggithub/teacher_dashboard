class Student < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :subject, presence: true
  validates :marks, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end