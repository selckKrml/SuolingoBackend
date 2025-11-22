# 🚀 GitHub Push Adımları

## 📋 Önkoşullar

- ✅ Git yüklü olmalı
- ✅ GitHub hesabı olmalı
- ✅ GitHub'da yeni repository oluşturulmalı

## 1️⃣ Git Kurulumunu Kontrol Et

```powershell
git --version
```

Eğer yüklü değilse: https://git-scm.com/download/win

## 2️⃣ Git Yapılandırması (İlk Kez)

```powershell
# Kullanıcı adını ayarla
git config --global user.name "Adınız Soyadınız"

# Email adresini ayarla (GitHub email'iniz)
git config --global user.email "email@example.com"

# Kontrol et
git config --list
```

## 3️⃣ GitHub'da Yeni Repository Oluştur

1. GitHub'a giriş yap: https://github.com
2. Sağ üstteki **+** → **New repository**
3. Repository adı: `SuolingoBackend`
4. Description: "Rails 8 API Backend for Avatar-based Language Learning Application"
5. **Public** veya **Private** seç
6. ❌ **Initialize this repository with a README** - İŞARETLEME (zaten var)
7. **Create repository** tıkla

## 4️⃣ Local Repository'yi Başlat

```powershell
# Proje dizinine git
cd C:\SuolingoBackend

# Git repository'yi başlat
git init

# Tüm dosyaları staging area'ya ekle
git add .

# İlk commit'i yap
git commit -m "Initial commit: Rails 8 API with PostgreSQL, complete CRUD operations and Postman tests"
```

## 5️⃣ GitHub Repository'yi Bağla

GitHub'da yeni oluşturduğunuz repository sayfasında gösterilen URL'yi kullanın:

```powershell
# Remote repository ekle (URL'i kendi repository URL'inizle değiştirin)
git remote add origin https://github.com/KULLANICI_ADINIZ/SuolingoBackend.git

# Remote kontrolü
git remote -v
```

## 6️⃣ Push Et

```powershell
# Main branch'e push et
git push -u origin main

# Eğer "main" branch yok hatası alırsanız:
git branch -M main
git push -u origin main
```

## 🔐 GitHub Authentication

### Option 1: Personal Access Token (Önerilen)

1. GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. **Generate new token (classic)**
3. Note: "SuolingoBackend Access"
4. Expiration: 90 days veya No expiration
5. Scopes: **repo** seçeneğini işaretle
6. **Generate token**
7. Token'ı kopyala ve **GÜVENLİ BİR YERE KAYDET** (bir daha gösterilmeyecek)

Push yaparken:
- Username: GitHub kullanıcı adınız
- Password: **Token'ı buraya yapıştırın**

### Option 2: GitHub CLI (Alternatif)

```powershell
# GitHub CLI kur
winget install --id GitHub.cli

# Login ol
gh auth login

# Repository oluştur ve push et
gh repo create SuolingoBackend --public --source=. --remote=origin --push
```

## 7️⃣ Doğrulama

```powershell
# Remote branch'leri kontrol et
git branch -r

# Son commit'i göster
git log --oneline -1

# GitHub'da repository'yi aç
start https://github.com/KULLANICI_ADINIZ/SuolingoBackend
```

## 🔄 Gelecekte Değişiklik Push Etme

```powershell
# Değişiklikleri kontrol et
git status

# Değişiklikleri ekle
git add .

# Commit yap
git commit -m "Açıklayıcı commit mesajı"

# Push et
git push
```

## 📝 İyi Commit Mesajı Örnekleri

```bash
# Feature eklerken
git commit -m "Add: Message CRUD operations with conversation context"

# Bug fix
git commit -m "Fix: Learning path delete 404 error in Postman tests"

# Update
git commit -m "Update: Postman collection to 15 essential tests"

# Documentation
git commit -m "Docs: Add comprehensive API testing documentation"

# Refactor
git commit -m "Refactor: Improve Messages controller error handling"
```

## 🌿 Branch Stratejisi (İsteğe Bağlı)

```powershell
# Development branch oluştur
git checkout -b development

# Feature branch oluştur
git checkout -b feature/new-feature

# Main'e merge et
git checkout main
git merge feature/new-feature

# Branch'i sil
git branch -d feature/new-feature
```

## ⚠️ Önemli Notlar

1. **Sensitive Data:** `.env` dosyaları ve şifreler asla push edilmemeli (`.gitignore` bunu engelliyor)
2. **Database:** PostgreSQL şifreleri `.gitignore` ile korunuyor
3. **Credentials:** Rails credentials encrypted olarak saklanıyor
4. **Large Files:** 100MB'den büyük dosyalar GitHub'a yüklenemez

## 🆘 Sorun Giderme

### "Permission denied" hatası
```powershell
# SSH key oluştur
ssh-keygen -t ed25519 -C "email@example.com"

# SSH key'i GitHub'a ekle
# GitHub → Settings → SSH and GPG keys → New SSH key
# %USERPROFILE%\.ssh\id_ed25519.pub içeriğini kopyala

# SSH kullanarak remote değiştir
git remote set-url origin git@github.com:KULLANICI_ADINIZ/SuolingoBackend.git
```

### "Repository not found" hatası
```powershell
# Remote URL'i kontrol et
git remote -v

# Doğru URL ile değiştir
git remote set-url origin https://github.com/KULLANICI_ADINIZ/SuolingoBackend.git
```

### "Rejected - non-fast-forward" hatası
```powershell
# Remote'taki değişiklikleri çek
git pull origin main --rebase

# Conflict varsa düzelt ve devam et
git add .
git rebase --continue

# Push et
git push
```

## 🎯 Hızlı Başlangıç (Tek Seferde)

```powershell
# 1. Git yapılandırması (ilk kez)
git config --global user.name "Adınız Soyadınız"
git config --global user.email "email@example.com"

# 2. Repository başlat ve commit
cd C:\SuolingoBackend
git init
git add .
git commit -m "Initial commit: Rails 8 API with PostgreSQL"

# 3. GitHub'a bağla ve push et (URL'i değiştir)
git remote add origin https://github.com/KULLANICI_ADINIZ/SuolingoBackend.git
git branch -M main
git push -u origin main
```

## 📚 Ek Kaynaklar

- Git Documentation: https://git-scm.com/doc
- GitHub Guides: https://guides.github.com
- Git Cheat Sheet: https://education.github.com/git-cheat-sheet-education.pdf

---

**Hazırlayan:** GitHub Copilot  
**Tarih:** 22 Kasım 2025  
**Proje:** Suolingo Backend v2.0
