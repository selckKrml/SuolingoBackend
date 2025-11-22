# Avatar Destekli Dil Öğrenme Uygulaması - Backend API

Rails 8 API Backend for Avatar-based Language Learning Application

## 📋 Genel Bakış

Bu proje, avatar destekli dil öğrenme uygulaması için Rails 8 ile geliştirilmiş bir JSON API backend'idir. Kullanıcılar, sanal avatar'lar ile farklı zorluk seviyelerinde konuşma yaparak dil öğrenebilirler.

## 🚀 Quick Start

```powershell
# 1. Start PostgreSQL
& "C:\Program Files\PostgreSQL\16\bin\pg_ctl.exe" -D "C:\Program Files\PostgreSQL\16\data" start

# 2. Setup database
rails db:setup

# 3. Start server
rails server -p 3000
```

Server: `http://localhost:3000`

## 📚 Documentation

- 📋 **[Test Structure](docs/POSTMAN_TEST_STRUCTURE.md)** - Comprehensive test organization
- 🔄 **[Test Flow Diagram](docs/POSTMAN_TEST_FLOW.md)** - Visual test execution flow
- 📖 **[Project Summary](docs/PROJECT_SUMMARY.md)** - Complete architecture overview
- 🧪 **[Postman Testing Guide](docs/POSTMAN_TESTING_GUIDE.md)** - API testing instructions
- 🗄️ **[PostgreSQL Setup](docs/POSTGRESQL_SETUP_SUCCESS.md)** - Database configuration
- 📡 **[OpenAPI Spec](docs/openapi.yaml)** - API specification

## 🏗️ Teknik Özellikler

- **Framework:** Ruby on Rails 8.1.1
- **Mimari:** API Only Mode (Session/Cookie kullanılmaz)
- **Veritabanı:** PostgreSQL 16
- **Authentication:** BCrypt ile güvenli password hashing
- **CORS:** Tüm origin'lere izin verilmiş (production'da düzenlenebilir)
- **Response Format:** JSON

## 📦 Modeller ve İlişkiler

### 1. User (👥)
Kullanıcı bilgileri ve kimlik doğrulama
- `name` (string)
- `email` (string, unique)
- `password_digest` (string)

### 2. Avatar (🤖)
Dil öğretmeni avatar'lar
- `name` (string)
- `voice_id` (string) - Ses ID'si
- `personality` (text) - Kişilik özellikleri
- `image_url` (string) - Avatar görseli
- `language` (string) - Örn: "Spanish"
- `language_code` (string) - Örn: "es-ES"

**İlişkiler:** `has_many :conversations`

### 3. LearningPath (📚)
Yapılandırılmış öğrenme kursları
- `title` (string) - Kurs başlığı
- `description` (text) - Açıklama
- `difficulty_level` (integer, 1-5)
- `estimated_hours` (integer)
- `total_lessons` (integer)
- `is_published` (boolean)

**İlişkiler:** `has_many :conversations`

### 4. Conversation (💬)
Dil öğrenme oturumları
- `title` (string) - Konuşma başlığı
- `difficulty_level` (integer, 1-5)
  - 1: Beginner
  - 2: Elementary
  - 3: Intermediate
  - 4: Upper Intermediate
  - 5: Advanced
- `avatar_id` (foreign key)
- `learning_path_id` (foreign key)
- `target_language_id` (references)
- `avatar_id` (references)

**İlişkiler:**
- `belongs_to :avatar`
- `belongs_to :target_language`
- `has_many :messages`

### 5. Message
Konuşma içindeki mesajlar
- `content` (text) - Mesaj içeriği
- `sender_type` (string) - 'user' veya 'avatar'
- `audio_url` (string) - Ses kaydı URL'i (opsiyonel)
- `conversation_id` (references)

**İlişkiler:** `belongs_to :conversation`

## 🚀 Kurulum

### Gereksinimler
- Ruby 3.3.0+
- Rails 8.1.1
- SQLite3 1.7+

### Adımlar

```powershell
# Bağımlılıkları yükle
bundle install

# Veritabanını oluştur
rails db:create

# Migration'ları çalıştır
rails db:migrate

# (Opsiyonel) Seed data ekle
rails db:seed

# Sunucuyu başlat
rails server
```

API şu adreste çalışacaktır: `http://localhost:3000`

## 📡 API Endpoints

### Users
- `GET /users` - Tüm kullanıcıları listele
- `GET /users/:id` - Kullanıcı detayı
- `POST /users` - Yeni kullanıcı oluştur
- `PUT /users/:id` - Kullanıcı güncelle
- `DELETE /users/:id` - Kullanıcı sil

### Avatars
- `GET /avatars` - Tüm avatar'ları listele
- `GET /avatars/:id` - Avatar detayı
- `POST /avatars` - Yeni avatar oluştur
- `PUT /avatars/:id` - Avatar güncelle
- `DELETE /avatars/:id` - Avatar sil

### Target Languages
- `GET /target_languages` - Tüm dilleri listele
- `GET /target_languages/:id` - Dil detayı
- `POST /target_languages` - Yeni dil ekle
- `PUT /target_languages/:id` - Dil güncelle
- `DELETE /target_languages/:id` - Dil sil

### Conversations
- `GET /conversations` - Tüm konuşmaları listele (avatar, dil ve mesajlar dahil)
- `GET /conversations/:id` - Konuşma detayı
- `POST /conversations` - Yeni konuşma oluştur
- `PUT /conversations/:id` - Konuşma güncelle
- `DELETE /conversations/:id` - Konuşma sil

### Messages
- `GET /conversations/:conversation_id/messages` - Konuşmadaki mesajları listele
- `GET /conversations/:conversation_id/messages/:id` - Mesaj detayı
- `POST /conversations/:conversation_id/messages` - Yeni mesaj ekle
- `PUT /conversations/:conversation_id/messages/:id` - Mesaj güncelle
- `DELETE /conversations/:conversation_id/messages/:id` - Mesaj sil

### Health Check
- `GET /up` - API sağlık kontrolü
- `GET /` - API bilgileri

## 📋 Scaffold Komutları

Modelleri oluşturmak için kullanılan komutlar:

```bash
# User
rails generate scaffold User name:string email:string password_digest:string --no-test-framework

# Avatar
rails generate scaffold Avatar name:string voice_id:string personality:text image_url:string --no-test-framework

# TargetLanguage
rails generate scaffold TargetLanguage name:string code:string --no-test-framework

# Conversation
rails generate scaffold Conversation title:string difficulty_level:integer target_language:references avatar:references --no-test-framework

# Message
rails generate scaffold Message content:text sender_type:string audio_url:string conversation:references --no-test-framework
```

**Not:** Windows'ta Rails 8 ile SQLite3 uyumluluk sorunları nedeniyle, bu projede modeller ve controller'lar manuel olarak oluşturulmuştur.

## 📚 Dokümantasyon

### UML Diagram
`docs/architecture.yuml` dosyası yuml.me formatında UML diyagramını içerir.

**Görüntüleme:** https://yuml.me/diagram/scruffy/class/ adresine dosya içeriğini yapıştırarak görselleştirebilirsiniz.

### Postman Collection

#### ✅ Önerilen: Sequential Test Collection (v2)
`docs/postman_collection_v2.json` - Otomatik ID yönetimi ve sıralı testler içerir.

**Özellikler:**
- ✅ Otomatik ID kaydı (CREATE işlemlerinden sonra ID'ler kaydedilir)
- ✅ Dynamic variables (timestamp, randomInt, randomFirstName)
- ✅ Test scripts ile otomatik doğrulama
- ✅ Sıralı çalıştırma desteği (Collection Runner ile)
- ✅ 404 ve 422 hatası yok - her test başarılı olacak şekilde tasarlandı

**Import Adımları:**
1. Postman'i açın
2. Import > File > `docs/postman_collection_v2.json` seçin
3. Collection Runner ile tüm testleri sırayla çalıştırın

**Manuel Test İçin:**
- Requestleri yukarıdan aşağıya sırayla çalıştırın (1-19)
- DELETE işlemleri 204 No Content dönecektir

#### 📦 Alternatif: Klasik Collection
`docs/postman_collection.json` - Temel endpoint collection (manuel ID yönetimi gerekir)

### OpenAPI/Swagger Dokümantasyonu
`docs/openapi.yaml` dosyası OpenAPI 3.0.3 standardında API dokümantasyonunu içerir.

**Görüntüleme Seçenekleri:**
- https://editor.swagger.io/ adresinde dosyayı açın
- VS Code'da "OpenAPI (Swagger) Editor" extension kullanın
- Redoc veya SwaggerUI ile local server'da host edin

## 🧪 Test Endpoint'leri

### Örnek Requests

#### 1. Yeni Avatar Oluştur
```bash
curl -X POST http://localhost:3000/avatars \
  -H "Content-Type: application/json" \
  -d '{
    "avatar": {
      "name": "Sofia",
      "voice_id": "voice_en_us_001",
      "personality": "Friendly and patient language tutor",
      "image_url": "https://example.com/avatars/sofia.png"
    }
  }'
```

#### 2. Yeni Dil Ekle
```bash
curl -X POST http://localhost:3000/target_languages \
  -H "Content-Type: application/json" \
  -d '{
    "target_language": {
      "name": "English",
      "code": "en-US"
    }
  }'
```

#### 3. Konuşma Oluştur
```bash
curl -X POST http://localhost:3000/conversations \
  -H "Content-Type: application/json" \
  -d '{
    "conversation": {
      "title": "Ordering Food at a Restaurant",
      "difficulty_level": 2,
      "target_language_id": 1,
      "avatar_id": 1
    }
  }'
```

#### 4. Mesaj Gönder
```bash
curl -X POST http://localhost:3000/conversations/1/messages \
  -H "Content-Type: application/json" \
  -d '{
    "message": {
      "content": "Hello! I would like to order something.",
      "sender_type": "user",
      "audio_url": "https://example.com/audio/user_001.mp3"
    }
  }'
```

#### 5. Konuşmaları Listele
```bash
curl http://localhost:3000/conversations
```

## 🔧 Yapılandırma

### CORS Ayarları
`config/initializers/cors.rb` dosyasında CORS ayarlarını düzenleyebilirsiniz. Production için belirli domain'lere izin verilmesi önerilir.

### Database
`config/database.yml` dosyasında veritabanı ayarlarını görebilirsiniz. Production ortamında PostgreSQL veya MySQL kullanılması önerilir.

## 🐛 Bilinen Sorunlar

1. **Windows SQLite3 Uyumluluk:** Rails 8 SQLite3 >= 2.1 gerektirir ancak Windows'ta native extension sorunları var. Bu projede 1.7 versiyonu kullanılmıştır.

2. **Veritabanı Migrations:** `rails db:migrate` komutunu çalıştırmadan önce `rails db:create` komutunun çalıştırıldığından emin olun.

## 📝 Gelecek Geliştirmeler

- [ ] JWT Authentication implementasyonu
- [ ] User roles ve permissions (admin, student, teacher)
- [ ] Avatar response AI integration
- [ ] Audio file upload ve storage (Active Storage)
- [ ] Real-time messaging (Action Cable)
- [ ] Progress tracking ve analytics
- [ ] Rate limiting ve API throttling
- [ ] Comprehensive test coverage

## 📄 Lisans

Bu proje eğitim amaçlı geliştirilmiştir.

## 👤 İletişim

Sorular ve öneriler için: support@suolingo.com

---

**Not:** Bu API modern Rails 8 standartlarına uygun, temiz ve bakımı kolay bir şekilde tasarlanmıştır. Production kullanımı için authentication, authorization ve güvenlik katmanları eklenmelidir.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
