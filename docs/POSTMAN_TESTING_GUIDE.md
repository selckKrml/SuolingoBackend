# Postman Collection Test Rehberi

## 🎯 Sorun ve Çözüm

### ❌ Eski Sorunlar:
1. **404 Errors:** Sabit ID'ler kullanıldığı için test sırasında silinmiş kayıtlar bulunmuyordu
2. **422 Error (Target Language):** `code` alanı unique olduğu için aynı değer tekrar eklenemiyordu
3. **DELETE Response Confusion:** 404 vs 204 karmaşası

### ✅ Çözümler:
1. **Dynamic ID Management:** Her CREATE işleminden sonra dönen ID otomatik kaydediliyor
2. **Unique Values:** `{{$timestamp}}` ve `{{$randomInt}}` ile her test benzersiz veri oluşturuyor
3. **Sequential Testing:** Testler 1-19 arası sırayla çalıştırılıyor
4. **Test Scripts:** Her request sonrası otomatik doğrulama yapılıyor

---

## 📁 Dosyalar

### 1. `postman_collection_v2.json` ✅ ÖNERİLEN
- **19 request** içerir
- Otomatik ID yönetimi
- Test scripts ile doğrulama
- Collection Runner desteği
- 404/422 hatası YOK

### 2. `postman_collection.json` (Eski)
- Manuel ID yönetimi gerekir
- Test script yok
- Referans amaçlı

---

## 🚀 Kullanım

### Adım 1: PostgreSQL'i Başlat
```powershell
# Manuel başlatma
& "C:\Program Files\PostgreSQL\16\bin\pg_ctl.exe" start -D "C:\Program Files\PostgreSQL\16\data"

# VEYA servis olarak (otomatik)
Start-Service postgresql-16
```

### Adım 2: Rails Sunucusunu Başlat
```powershell
cd c:\SuolingoBackend
rails server
```

### Adım 3: Postman'de Collection'ı Import Et
1. Postman'i aç
2. **Import** butonuna tıkla
3. **`docs/postman_collection_v2.json`** dosyasını seç
4. **Import** tıkla

### Adım 4: Collection Runner ile Toplu Test
1. Collection'a sağ tıkla
2. **"Run collection"** seç
3. **"Run Suolingo API - Sequential Tests"** butonuna tıkla
4. 19 test otomatik sırayla çalışacak

**Beklenen Sonuç:**
```
✅ 19/19 tests passed
✅ 0 failed
✅ All DELETE operations returned 204 No Content
```

### Adım 5: Manuel Test (Tek Tek)
Testleri yukarıdan aşağıya sırayla çalıştır:

1. ✅ Health Check
2. ✅ Get All Avatars
3. ✅ **Create Avatar** → ID kaydedilir
4. ✅ Get Avatar by ID (kaydedilen ID ile)
5. ✅ Update Avatar
6. ✅ Get All Target Languages
7. ✅ **Create Target Language** → unique code ile
8. ✅ **Create Conversation** → Avatar ve Language ID'lerini kullanır
9. ✅ Get All Conversations
10. ✅ **Create Message (User)** → Conversation ID kullanır
11. ✅ Get All Messages
12. ✅ Update Message
13. ✅ **Create User**
14. ✅ Get Conversation by ID
15. ✅ **Delete Message** → 204 No Content
16. ✅ **Delete Conversation** → 204 No Content
17. ✅ **Delete Avatar** → 204 No Content
18. ✅ **Delete Target Language** → 204 No Content
19. ✅ **Delete User** → 204 No Content

---

## 🔍 Test Scripts Özellikleri

### Otomatik ID Kaydetme (CREATE işlemleri)
```javascript
pm.test("Save new avatar ID", function () {
    var jsonData = pm.response.json();
    pm.collectionVariables.set("new_avatar_id", jsonData.id);
    console.log("Created Avatar ID: " + jsonData.id);
});
```

### Status Code Doğrulama
```javascript
pm.test("Status is 201", function () {
    pm.response.to.have.status(201);
});

pm.test("Status is 204 No Content", function () {
    pm.response.to.have.status(204);
});
```

### Response Validation
```javascript
pm.test("Response includes nested relations", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData).to.have.property('avatar');
    pm.expect(jsonData).to.have.property('target_language');
});
```

---

## 📊 Collection Variables

| Variable | Açıklama | Örnek |
|----------|----------|-------|
| `base_url` | API base URL | `http://localhost:3000` |
| `new_user_id` | Son oluşturulan User ID | `5` |
| `new_avatar_id` | Son oluşturulan Avatar ID | `4` |
| `new_language_id` | Son oluşturulan Language ID | `5` |
| `new_conversation_id` | Son oluşturulan Conversation ID | `3` |
| `new_message_id` | Son oluşturulan Message ID | `4` |

**Not:** Bu değerler CREATE işlemlerinden sonra otomatik güncellenir.

---

## 🎲 Dynamic Variables

Postman'in yerleşik değişkenleri:

| Variable | Açıklama | Örnek |
|----------|----------|-------|
| `{{$timestamp}}` | Unix timestamp | `1732280000` |
| `{{$randomInt}}` | Random integer | `42857` |
| `{{$randomFirstName}}` | Random isim | `Emma` |

**Kullanım:**
```json
{
  "target_language": {
    "name": "Test Language {{$randomInt}}",
    "code": "test-{{$timestamp}}"
  }
}
```

Bu sayede her test benzersiz veri oluşturur → **422 Unique constraint hatası yok!**

---

## ⚠️ Sık Karşılaşılan Sorunlar

### 1. "Could not get any response"
**Çözüm:** Rails sunucusunun çalıştığını kontrol et
```powershell
Get-Process | Where-Object {$_.ProcessName -like "*ruby*"}
```

### 2. "PG::ConnectionBad - Connection refused"
**Çözüm:** PostgreSQL'i başlat
```powershell
& "C:\Program Files\PostgreSQL\16\bin\pg_ctl.exe" start -D "C:\Program Files\PostgreSQL\16\data"
```

### 3. "404 Not Found" (Manuel test ederken)
**Çözüm:** Testleri sırayla çalıştır. CREATE işlemlerinden sonra ID'ler kaydedilir.

### 4. "422 Unprocessable Entity" (Target Language)
**Çözüm:** `postman_collection_v2.json` kullan. Dynamic `{{$timestamp}}` ile unique code oluşturur.

---

## 🎯 Başarı Kriterleri

### ✅ Başarılı Test Çıktısı:
- **Status Codes:**
  - GET → 200 OK
  - POST → 201 Created
  - PUT → 200 OK
  - DELETE → 204 No Content

- **Response Format:**
  - Valid JSON
  - Nested relations (avatar, target_language, messages)
  - Enum values string olarak (örn: "elementary")

- **Data Integrity:**
  - Foreign key constraints çalışıyor
  - Unique constraints çalışıyor
  - Password encryption çalışıyor

### 📈 Test Metrikleri:
```
Total Requests: 19
Passed: 19
Failed: 0
Average Response Time: < 100ms
```

---

## 🔄 Test Sonrası Temizlik

Collection Runner tüm CREATE işlemlerini DELETE ile temizler:
1. Message silindi
2. Conversation silindi
3. Avatar silindi
4. Target Language silindi
5. User silindi

**Veritabanı orijinal haline döner!**

---

## 📚 Ek Kaynaklar

- **API Dokümantasyonu:** `docs/openapi.yaml` (Swagger Editor'de aç)
- **UML Diagram:** `docs/architecture.yuml` (yuml.me'de görselleştir)
- **Proje Özeti:** `docs/PROJECT_SUMMARY.md`
- **PostgreSQL Kurulum:** `docs/POSTGRESQL_SETUP_SUCCESS.md`

---

## ✅ Sonuç

Yeni `postman_collection_v2.json` ile:
- ❌ 404 hatası yok
- ❌ 422 hatası yok
- ✅ Tüm DELETE işlemleri 204 dönüyor
- ✅ Otomatik ID yönetimi
- ✅ Sıralı test desteği
- ✅ Test script doğrulama

**Postman Collection hazır, test edebilirsin!** 🚀
