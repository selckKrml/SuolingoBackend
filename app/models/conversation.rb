# == Schema Information
#
# Table name: conversations
#
#  id                 :integer          not null, primary key
#  title              :string
#  difficulty_level   :integer
#  target_language_id :integer          not null
#  avatar_id          :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Conversation < ApplicationRecord
  belongs_to :avatar
  belongs_to :learning_path, optional: true
  has_many :messages, dependent: :destroy
  
  validates :title, presence: true
  validates :difficulty_level, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true, on: :create
  
  enum :difficulty_level, {
    beginner: 1,
    elementary: 2,
    intermediate: 3,
    upper_intermediate: 4,
    advanced: 5
  }
end
