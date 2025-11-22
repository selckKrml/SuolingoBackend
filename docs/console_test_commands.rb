# Rails Console Quick Test Commands

# Bu dosyayı Rails console'da kullanmak için:
# rails console
# load 'docs/console_test_commands.rb'

puts "🧪 Avatar Destekli Dil Öğrenme API - Test Komutları"
puts "=" * 60

# Test 1: Model sayılarını kontrol et
puts "\n📊 Database Stats:"
puts "  Users: #{User.count}"
puts "  Avatars: #{Avatar.count}"
puts "  Target Languages: #{TargetLanguage.count}"
puts "  Conversations: #{Conversation.count}"
puts "  Messages: #{Message.count}"

# Test 2: İlişkileri kontrol et
puts "\n🔗 Testing Relationships:"
if Avatar.first
  avatar = Avatar.first
  puts "  ✅ Avatar '#{avatar.name}' has #{avatar.conversations.count} conversations"
end

if TargetLanguage.first
  lang = TargetLanguage.first
  puts "  ✅ Language '#{lang.name}' has #{lang.conversations.count} conversations"
end

if Conversation.first
  conv = Conversation.first
  puts "  ✅ Conversation '#{conv.title}' has #{conv.messages.count} messages"
  puts "     - Avatar: #{conv.avatar.name}" if conv.avatar
  puts "     - Language: #{conv.target_language.name}" if conv.target_language
end

# Test 3: Validations
puts "\n✅ Testing Validations:"
begin
  User.create!(name: "", email: "test@test.com", password: "123")
  puts "  ❌ User validation FAILED - should require name"
rescue => e
  puts "  ✅ User validation working (name required)"
end

begin
  Avatar.create!(name: "Test", voice_id: "")
  puts "  ❌ Avatar validation FAILED - should require voice_id"
rescue => e
  puts "  ✅ Avatar validation working (voice_id required)"
end

# Test 4: Sample queries
puts "\n🔍 Sample Queries:"
puts "  All English conversations: #{Conversation.joins(:target_language).where(target_languages: {code: 'en-US'}).count}"
puts "  Beginner level conversations: #{Conversation.where(difficulty_level: 1).count}"
puts "  User messages: #{Message.where(sender_type: 'user').count}"
puts "  Avatar messages: #{Message.where(sender_type: 'avatar').count}"

puts "\n✨ Test completed!"
puts "=" * 60

# Kullanışlı console komutları
puts "\n💡 Useful Console Commands:"
puts "  User.all                              # Tüm kullanıcılar"
puts "  Avatar.find(1).conversations          # Avatar'ın konuşmaları"
puts "  Conversation.includes(:messages).all  # Eager loading ile"
puts "  Message.where(sender_type: 'user')    # Kullanıcı mesajları"
puts "  TargetLanguage.find_by(code: 'en-US') # Kod ile bul"
puts ""
