# == Schema Information
#
# Table name: avatars
#
#  id          :integer          not null, primary key
#  name        :string
#  voice_id    :string
#  personality :text
#  image_url   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Avatar < ApplicationRecord
  has_many :conversations, dependent: :destroy
  
  validates :name, presence: true
  validates :voice_id, presence: true
  validates :language, presence: true
  validates :language_code, presence: true
  
  # Dil kodları için scope'lar
  scope :by_language, ->(lang) { where(language: lang) }
  scope :by_language_code, ->(code) { where(language_code: code) }
end
