# Game Design Document (GDD)
**Judul Sementara Proyek:** *Langkah Pertama di Kota* (Working Title: *Anak Rantau*)  
**Genre:** 2D Pixel Art Narrative Life-Sim / Slice of Life RPG  
**Engine:** Godot 4 (GDScript)  
**Target Platform:** PC (Windows)  
**Target Rilis Awal:** Itch.io (Free Demo / Name Your Price)  
**Bahasa:** Bahasa Indonesia  
**Estimasi Durasi Main:** 4 – 8 Jam (Full Release) | 20 – 30 Menit (Vertical Slice / MVP Demo)  

---

## 1. Visi & Premis Game
*Langkah Pertama di Kota* adalah game naratif slice of life 2D pixel art yang mengangkat kisah hangat, getir, dan penuh nostalgia tentang seorang pemuda desa lugu yang pertama kali menginjakkan kaki di kota besar demi melunasi utang keluarga.

### Tagline & Pesan Emosional
> *"Kota ini mungkin bising dan dingin, tapi di sela gang sempit dan aroma kopi tubruk, selalu ada kehangatan yang tak terduga."*
- **Pesan Moral:** Menghargai perjuangan hidup, belajar menaruh batas antara kerja keras dan menjaga kewarasan diri, serta menemukan arti keluarga baru di perantauan.

---

## 2. Core Pillars (Pilar Desain)
1. **Relatable & Nostalgik:** Menangkap detail nyata kehidupan Indonesia—kamar kos petak, suara motor bebek di kejauhan, obrolan warkop, pamali orang tua dari kampung, hingga gorengan hangat di sore hari.
2. **Semi-Open Directed Exploration (GTA-Style Questing):** Pemain bebas melangkah dan menentukan urutan kegiatan harian, namun selalu dibekali arahan yang jelas melalui Jurnal Agenda.
3. **Ekspresi Visual yang Hidup:** Dialog tidak sekadar teks berjalan; karakter dilengkapi potret wajah 32-bit ekspresif yang mencerminkan emosi (senyum, bingung, panik, haru).
4. **Survival Santai Berbasis Nilai Kemanusiaan:** Tantangan bukan kematian permanen, melainkan mengelola Uang, Energi, Lapar, dan Stres agar tidak jatuh sakit sebelum deadline sewa kos.

---

## 3. Karakteristik Dunia & Setting
- **Latar:** Distrik pinggiran kota fiktif terinspirasi kota-kota satelit Indonesia (era modern kontemporer yang tenang, paduan ruko tua dan gang pemukiman padat).
- **Aturan Dunia:** 100% Realistis. Tidak ada sihir atau monster.
- **Lokasi Utama (MVP Distrik Terpadu):**
  1. *Kamar Kos MC:* Tempat tidur (save & ganti hari), cermin, kalender target utang.
  2. *Lorong & Halaman Kos Bu Wati:* Tempat jemuran, kamar tetangga kos, meja Bu Kos.
  3. *Gang Rukun & Pos Ronda:* Tempat warga nongkrong sore, main catur, jajan cilok.
  4. *Warkop & Warteg Cak Man:* Hub sosial utama, beli makan pengganjal perut, info lowongan kerja.
  5. *Pasar Gang Anyar / Ruko:* Tempat kerja serabutan (bongkar muat, jaga toko kelontong), lokasi terjadinya insiden preman.

---

## 4. Mekanik & Core Loop Gameplay

### 4.1 Daily Life Cycle (Loop Harian)
```
[Bangun Pagi di Kos] 
       ↓
[Cek Jurnal Agenda & Status (Uang, Energi, Lapar, Stres)]
       ↓
[Eksplorasi Kota & Interaksi Warga / Ambil Kerja Sampingan]
       ↓
[Pergeseran Waktu (Pagi → Siang → Sore → Malam)]
       ↓
[Makan / Nongkrong untuk Mengurangi Stres & Lapar]
       ↓
[Tidur di Kasur Kosan → Hitung Pengeluaran/Pendapatan Harian]
```

### 4.2 Sistem Parameter Pemain
1. **Uang (Rp):** Digunakan untuk membayar sewa kos mingguan, membeli makan, obat, dan disisihkan untuk dikirim ke kampung.
2. **Energi (0–100):** Berkurang saat bekerja fisik atau berjalan jauh. Diisi ulang dengan tidur malam atau minum kopi.
3. **Lapar (0–100):** Jika di bawah 20, konsumsi energi berlipat ganda. Dipulihkan dengan makan di warteg atau jajan pasar.
4. **Stres / Mood (0–100):** Naik jika terus bekerja tanpa istirahat atau mengalami kejadian buruk (misal ditipu). Diturunkan dengan nongkrong santai, mendengarkan radio, atau ngobrol dengan teman.
5. **Waktu (Time Slots):** Sistem 4 Fase per hari: **Pagi**, **Siang**, **Sore**, **Malam**. Waktu berganti secara terukur berdasarkan penyelesaian aksi/kegiatan kerja, bukan timer real-time yang membebani.

### 4.3 Sistem Dialog & Relasi
- **Branching Dialogue:** Pilihan respons yang mempengaruhi level kedekatan (Affection/Trust) dengan NPC.
- **Visual Portraits:** Karakter memiliki variasi ekspresi: Netral, Senyum, Kaget, Malu/Canggung, Sedih, dan Kesal.
- **Folklore & Pamali Integration:** Interaksi memuat nasihat kampung (misal: dialog peringatan pamali nyapu malam yang jika dipatuhi membuka momen dialog unik).

### 4.4 Street Clash (Sistem Berantem Turn-Based Kasual)
- Dipicu pada momen cerita tertentu (misal: dipalak preman pasar atau membela teman).
- **Mekanik:** Layar beralih ke tampilan duel berhadapan santai ala *Earthbound/Undertale*:
  - **Pukul:** Serangan fisik dasar (mengonsumsi sedikit energi).
  - **Tangkis:** Mengurangi damage musuh dan memulihkan sedikit fokus.
  - **Ngeles / Gertak:** Menurunkan mental musuh.
  - **Ajak Damai / Sodorkan Kopi:** Pilihan diplomasi khas warga lokal yang bisa mengakhiri duel tanpa kekerasan jika kondisi dialog terpenuhi.

---

## 5. Multiple Endings (Kondisi Akhir)
1. **Good Ending — "Akar Baru di Tanah Rantau":**
   - Target utang lunas tepat waktu.
   - Reputasi warga tinggi. MC menjadi bagian tak terpisahkan dari warga gang, memulai usaha mandiri kecil di kota.
2. **Bittersweet Ending — "Beban yang Terbayar":**
   - Utang lunas, namun relasi warga rendah (MC terlalu memaksakan diri bekerja dan mengabaikan interaksi sosial).
   - MC pulang ke kampung dengan uang pelunas utang namun membawa rasa hampa dan kelelahan.
3. **Hard Truth Ending — "Gotong Royong":**
   - Target uang tidak tercapai akibat insiden penipuan mid-point.
   - Karena kebaikan dan kepedulian MC selama tinggal di kosan, Bu Kos dan warga warkop patungan memberikan pinjaman lunak serta perlindungan kekeluargaan.

---

## 6. Spesifikasi Minimum Vertical Slice (MVP Demo)
- **Cakupan Cerita:** Hari ke-1 hingga Hari ke-3 di kota.
- **Fitur Teruji:**
  - Navigasi 2D top-down 4 arah dengan collision halus.
  - UI Status (Uang, Energi, Lapar, Stres, Jam/Fase Hari).
  - Jurnal tugas aktif.
  - Dialog interaktif dengan portrait untuk 4 NPC utama.
  - 1 Mini-game kerja serabutan (membantu bongkar kardus di pasar).
  - 1 Skenario uji Street Clash turn-based di malam hari ke-2.
