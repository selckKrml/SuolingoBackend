# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  content         :text
#  sender_type     :string
#  audio_url       :string
#  conversation_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :conversation
  
  validates :content, presence: true
  validates :sender_type, presence: true, inclusion: { in: %w[user avatar] }
end
