# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Seed data for Avatar Destekli Dil Öğrenme Uygulaması

puts "🌱 Seeding database..."

# Clear existing data
puts "Clearing existing data..."
Message.destroy_all
Conversation.destroy_all
LearningPath.destroy_all
Avatar.destroy_all
User.destroy_all

# Reset sequences (PostgreSQL specific)
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('avatars')
ActiveRecord::Base.connection.reset_pk_sequence!('learning_paths')
ActiveRecord::Base.connection.reset_pk_sequence!('conversations')
ActiveRecord::Base.connection.reset_pk_sequence!('messages')

# Create sample users
puts "Creating users..."
users = [
  { name: "Ali Yılmaz", email: "ali@example.com", password: "password123", password_confirmation: "password123" },
  { name: "Ayşe Demir", email: "ayse@example.com", password: "password123", password_confirmation: "password123" },
  { name: "Mehmet Kaya", email: "mehmet@example.com", password: "password123", password_confirmation: "password123" },
  { name: "Zeynep Yıldız", email: "zeynep@example.com", password: "password123", password_confirmation: "password123" },
  { name: "Can Öztürk", email: "can@example.com", password: "password123", password_confirmation: "password123" }
]

users.each do |user_data|
  User.create!(user_data)
end
puts "✅ Created #{User.count} users"

# Create avatars with languages
puts "Creating avatars..."
avatars_data = [
  {
    name: "Sofia",
    voice_id: "voice_en_us_female_001",
    personality: "Friendly and patient English tutor from California.",
    image_url: "https://api.dicebear.com/7.x/avataaars/svg?seed=Sofia",
    language: "English",
    language_code: "en-US"
  },
  {
    name: "James",
    voice_id: "voice_en_uk_male_001",
    personality: "Professional British English teacher from London.",
    image_url: "https://api.dicebear.com/7.x/avataaars/svg?seed=James",
    language: "English",
    language_code: "en-GB"
  },
  {
    name: "Maria",
    voice_id: "voice_es_female_001",
    personality: "Energetic Spanish teacher who loves culture and food.",
    image_url: "https://api.dicebear.com/7.x/avataaars/svg?seed=Maria",
    language: "Spanish",
    language_code: "es-ES"
  },
  {
    name: "Pierre",
    voice_id: "voice_fr_male_001",
    personality: "Charming French teacher from Paris.",
    image_url: "https://api.dicebear.com/7.x/avataaars/svg?seed=Pierre",
    language: "French",
    language_code: "fr-FR"
  },
  {
    name: "Hans",
    voice_id: "voice_de_male_001",
    personality: "Precise and methodical German teacher.",
    image_url: "https://api.dicebear.com/7.x/avataaars/svg?seed=Hans",
    language: "German",
    language_code: "de-DE"
  },
  {
    name: "Yuki",
    voice_id: "voice_ja_female_001",
    personality: "Patient and encouraging Japanese teacher from Tokyo.",
    image_url: "https://api.dicebear.com/7.x/avataaars/svg?seed=Yuki",
    language: "Japanese",
    language_code: "ja-JP"
  }
]

avatars = avatars_data.map { |avatar_data| Avatar.create!(avatar_data) }
puts "✅ Created #{Avatar.count} avatars"

# Create learning paths
puts "Creating learning paths..."
learning_paths_data = [
  {
    title: "English for Beginners",
    description: "Learn basic English conversation skills for everyday situations",
    difficulty_level: 1,
    estimated_hours: 20,
    total_lessons: 15,
    is_published: true
  },
  {
    title: "English for Travel",
    description: "Essential English phrases for traveling abroad",
    difficulty_level: 2,
    estimated_hours: 15,
    total_lessons: 10,
    is_published: true
  },
  {
    title: "Business English",
    description: "Professional English for workplace communication",
    difficulty_level: 3,
    estimated_hours: 30,
    total_lessons: 20,
    is_published: true
  },
  {
    title: "Spanish Conversation",
    description: "Improve your Spanish speaking skills through real conversations",
    difficulty_level: 2,
    estimated_hours: 25,
    total_lessons: 12,
    is_published: true
  },
  {
    title: "French Basics",
    description: "Introduction to French language and culture",
    difficulty_level: 1,
    estimated_hours: 18,
    total_lessons: 12,
    is_published: true
  },
  {
    title: "German for Beginners",
    description: "Start your German learning journey",
    difficulty_level: 1,
    estimated_hours: 22,
    total_lessons: 14,
    is_published: true
  },
  {
    title: "Japanese Hiragana",
    description: "Master Japanese writing system and basic phrases",
    difficulty_level: 2,
    estimated_hours: 25,
    total_lessons: 15,
    is_published: true
  },
  {
    title: "Advanced English",
    description: "Advanced grammar and vocabulary for fluent speakers",
    difficulty_level: 5,
    estimated_hours: 40,
    total_lessons: 25,
    is_published: true
  }
]

learning_paths = learning_paths_data.map { |lp_data| LearningPath.create!(lp_data) }
puts "✅ Created #{LearningPath.count} learning paths"

# Create sample conversations with rich data
puts "Creating conversations..."
sofia = avatars[0]
james = avatars[1]
maria = avatars[2]
pierre = avatars[3]
hans = avatars[4]
yuki = avatars[5]

conversations_data = [
  {
    title: "Ordering Food at a Restaurant",
    difficulty_level: 2,
    avatar: sofia,
    learning_path: learning_paths[0]
  },
  {
    title: "Business Meeting Introduction",
    difficulty_level: 3,
    avatar: james,
    learning_path: learning_paths[2]
  },
  {
    title: "Shopping for Clothes",
    difficulty_level: 2,
    avatar: sofia,
    learning_path: learning_paths[1]
  },
  {
    title: "At the Airport",
    difficulty_level: 2,
    avatar: james,
    learning_path: learning_paths[1]
  },
  {
    title: "Making Friends - Spanish",
    difficulty_level: 2,
    avatar: maria,
    learning_path: learning_paths[3]
  },
  {
    title: "French Café Conversation",
    difficulty_level: 1,
    avatar: pierre,
    learning_path: learning_paths[4]
  },
  {
    title: "German Greetings",
    difficulty_level: 1,
    avatar: hans,
    learning_path: learning_paths[5]
  },
  {
    title: "Japanese Self Introduction",
    difficulty_level: 2,
    avatar: yuki,
    learning_path: learning_paths[6]
  },
  {
    title: "Advanced Business Negotiation",
    difficulty_level: 5,
    avatar: james,
    learning_path: learning_paths[7]
  },
  {
    title: "Casual English Chat",
    difficulty_level: 1,
    avatar: sofia,
    learning_path: learning_paths[0]
  }
]

conversations = conversations_data.map { |conv_data| Conversation.create!(conv_data) }
puts "✅ Created #{Conversation.count} conversations"

# Create rich sample messages
puts "Creating messages..."
messages_data = [
  # Conversation 1: Restaurant (5 messages)
  { conversation: conversations[0], sender_type: "avatar", content: "Hello! Welcome to our restaurant. How can I help you today?", audio_url: "https://example.com/audio/msg_001.mp3" },
  { conversation: conversations[0], sender_type: "user", content: "Hi! I would like to see the menu, please.", audio_url: "https://example.com/audio/msg_002.mp3" },
  { conversation: conversations[0], sender_type: "avatar", content: "Of course! Here's our menu. We have delicious pasta, fresh salads, and grilled seafood.", audio_url: "https://example.com/audio/msg_003.mp3" },
  { conversation: conversations[0], sender_type: "user", content: "I'll have the grilled salmon with salad, please.", audio_url: "https://example.com/audio/msg_004.mp3" },
  { conversation: conversations[0], sender_type: "avatar", content: "Excellent choice! Would you like anything to drink?", audio_url: "https://example.com/audio/msg_005.mp3" },
  
  # Conversation 2: Business Meeting (4 messages)
  { conversation: conversations[1], sender_type: "avatar", content: "Good morning everyone. Let's start our meeting.", audio_url: "https://example.com/audio/msg_006.mp3" },
  { conversation: conversations[1], sender_type: "user", content: "Good morning, James. Thank you for organizing this.", audio_url: "https://example.com/audio/msg_007.mp3" },
  { conversation: conversations[1], sender_type: "avatar", content: "Today we'll discuss the Q4 targets and our new marketing strategy.", audio_url: "https://example.com/audio/msg_008.mp3" },
  { conversation: conversations[1], sender_type: "user", content: "Sounds good. I've prepared a presentation on our social media campaigns.", audio_url: "https://example.com/audio/msg_009.mp3" },
  
  # Conversation 3: Shopping (6 messages)
  { conversation: conversations[2], sender_type: "avatar", content: "Hi there! Looking for anything specific today?", audio_url: "https://example.com/audio/msg_010.mp3" },
  { conversation: conversations[2], sender_type: "user", content: "Yes, I need a new jacket for winter.", audio_url: "https://example.com/audio/msg_011.mp3" },
  { conversation: conversations[2], sender_type: "avatar", content: "Great! What's your size?", audio_url: "https://example.com/audio/msg_012.mp3" },
  { conversation: conversations[2], sender_type: "user", content: "I'm a medium.", audio_url: "https://example.com/audio/msg_013.mp3" },
  { conversation: conversations[2], sender_type: "avatar", content: "Perfect! We have some beautiful leather jackets in stock. Would you like to try one?", audio_url: "https://example.com/audio/msg_014.mp3" },
  { conversation: conversations[2], sender_type: "user", content: "Yes, please! Can I see the black one?", audio_url: "https://example.com/audio/msg_015.mp3" },
  
  # Conversation 4: Airport (5 messages)
  { conversation: conversations[3], sender_type: "avatar", content: "Welcome to the check-in counter. May I see your passport, please?", audio_url: "https://example.com/audio/msg_016.mp3" },
  { conversation: conversations[3], sender_type: "user", content: "Here you go. I'm flying to New York.", audio_url: "https://example.com/audio/msg_017.mp3" },
  { conversation: conversations[3], sender_type: "avatar", content: "Thank you. Do you have any luggage to check in?", audio_url: "https://example.com/audio/msg_018.mp3" },
  { conversation: conversations[3], sender_type: "user", content: "Yes, just this suitcase.", audio_url: "https://example.com/audio/msg_019.mp3" },
  { conversation: conversations[3], sender_type: "avatar", content: "Perfect. Your boarding pass is ready. Gate 12, boarding at 3:30 PM.", audio_url: "https://example.com/audio/msg_020.mp3" },
  
  # Conversation 5: Spanish Friends (4 messages)
  { conversation: conversations[4], sender_type: "avatar", content: "¡Hola! ¿Cómo estás? Me llamo Maria.", audio_url: "https://example.com/audio/msg_021.mp3" },
  { conversation: conversations[4], sender_type: "user", content: "¡Hola Maria! Estoy bien, gracias. ¿Y tú?", audio_url: "https://example.com/audio/msg_022.mp3" },
  { conversation: conversations[4], sender_type: "avatar", content: "Muy bien, gracias. ¿De dónde eres?", audio_url: "https://example.com/audio/msg_023.mp3" },
  { conversation: conversations[4], sender_type: "user", content: "Soy de Turquía. ¿Y tú?", audio_url: "https://example.com/audio/msg_024.mp3" },
  
  # Conversation 6: French Café (3 messages)
  { conversation: conversations[5], sender_type: "avatar", content: "Bonjour! Bienvenue au café. Que désirez-vous?", audio_url: "https://example.com/audio/msg_025.mp3" },
  { conversation: conversations[5], sender_type: "user", content: "Bonjour! Un café au lait, s'il vous plaît.", audio_url: "https://example.com/audio/msg_026.mp3" },
  { conversation: conversations[5], sender_type: "avatar", content: "Parfait! Avec un croissant peut-être?", audio_url: "https://example.com/audio/msg_027.mp3" },
  
  # Conversation 7: German Greetings (3 messages)
  { conversation: conversations[6], sender_type: "avatar", content: "Guten Tag! Wie heißen Sie?", audio_url: "https://example.com/audio/msg_028.mp3" },
  { conversation: conversations[6], sender_type: "user", content: "Guten Tag! Ich heiße Can.", audio_url: "https://example.com/audio/msg_029.mp3" },
  { conversation: conversations[6], sender_type: "avatar", content: "Sehr gut, Can! Freut mich, Sie kennenzulernen.", audio_url: "https://example.com/audio/msg_030.mp3" },
  
  # Conversation 8: Japanese Introduction (3 messages)
  { conversation: conversations[7], sender_type: "avatar", content: "こんにちは！私は由紀です。お名前は？", audio_url: "https://example.com/audio/msg_031.mp3" },
  { conversation: conversations[7], sender_type: "user", content: "こんにちは！私はアリです。", audio_url: "https://example.com/audio/msg_032.mp3" },
  { conversation: conversations[7], sender_type: "avatar", content: "はじめまして、アリさん！よろしくお願いします。", audio_url: "https://example.com/audio/msg_033.mp3" },
  
  # Conversation 9: Advanced Business (2 messages)
  { conversation: conversations[8], sender_type: "avatar", content: "Let's discuss the terms of this partnership. What are your main objectives?", audio_url: "https://example.com/audio/msg_034.mp3" },
  { conversation: conversations[8], sender_type: "user", content: "We're looking for a long-term collaboration with clear KPIs and quarterly reviews.", audio_url: "https://example.com/audio/msg_035.mp3" },
  
  # Conversation 10: Casual Chat (4 messages)
  { conversation: conversations[9], sender_type: "avatar", content: "Hey! How's your day going?", audio_url: "https://example.com/audio/msg_036.mp3" },
  { conversation: conversations[9], sender_type: "user", content: "Pretty good, thanks! Just finished work.", audio_url: "https://example.com/audio/msg_037.mp3" },
  { conversation: conversations[9], sender_type: "avatar", content: "Nice! Any plans for the weekend?", audio_url: "https://example.com/audio/msg_038.mp3" },
  { conversation: conversations[9], sender_type: "user", content: "Yeah, I'm thinking of going hiking. How about you?", audio_url: "https://example.com/audio/msg_039.mp3" }
]

messages_data.each { |msg_data| Message.create!(msg_data) }
puts "✅ Created #{Message.count} messages"

puts ""
puts "🎉 Seeding completed!"
puts "📊 Summary:"
puts "  - Users: #{User.count}"
puts "  - Avatars: #{Avatar.count}"
puts "  - Learning Paths: #{LearningPath.count}"
puts "  - Conversations: #{Conversation.count}"
puts "  - Messages: #{Message.count}"
puts ""
puts "📋 Conversation Details:"
Conversation.includes(:messages).each do |conv|
  puts "  - ID: #{conv.id} | #{conv.title} | Messages: #{conv.messages.count}"
end
puts ""
puts "🚀 Start server with: rails server"
puts "💡 First conversation ID: #{Conversation.first&.id}"
