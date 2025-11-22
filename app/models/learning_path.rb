class LearningPath < ApplicationRecord
  has_many :conversations, dependent: :destroy
  
  enum :difficulty_level, {
    beginner: 1,
    elementary: 2,
    intermediate: 3,
    upper_intermediate: 4,
    advanced: 5
  }
  
  validates :title, presence: true
  validates :difficulty_level, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true, on: :create
  validates :estimated_hours, numericality: { greater_than: 0 }, allow_nil: true
  validates :total_lessons, numericality: { greater_than: 0 }, allow_nil: true
end
