# == Schema Information
#
# Table name: target_languages
#
#  id         :integer          not null, primary key
#  name       :string
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TargetLanguage < ApplicationRecord
  has_many :conversations, dependent: :destroy
  
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
end
