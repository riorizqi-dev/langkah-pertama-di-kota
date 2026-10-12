# Roadmap Pengembangan & Sesi Vibe Coding (ROADMAP.md)
**Proyek:** *Langkah Pertama di Kota*  
**Engine:** Godot 4.x (GDScript)  
**Filosofi:** Satu tugas kecil = Satu sesi prompt vibe coding yang selesai dan terverifikasi berjalan tanpa error.

---

## Ringkasan Milestone
- **Milestone 0: Fondasi Proyek & Arsitektur Inti** (Setup Godot, GameState Autoload, Screen Manager).
- **Milestone 1: Prototype Pergerakan & Eksplorasi 2D** (Player top-down, Map Kos & Gang, Camera).
- **Milestone 2: Sistem Dialog & Visual Portraits** (UI Dialog, Parser teks, pergantian ekspresi wajah).
- **Milestone 3: Sistem Survival & Manajemen Waktu** (Stat Uang, Energi, Lapar, Stres, Siklus Waktu Pagi–Malam).
- **Milestone 4: Sistem Quest & Jurnal Tugas** (Jurnal ala GTA, penanda tujuan, pembaruan status cerita).
- **Milestone 5: Mini-Game Kerja Serabutan & Street Clash** (Mini-game angkat kardus pasar + Turn-based clash duel).
- **Milestone 6: Integrasi Demo Vertical Slice (Hari 1–3)** (Polish audio/SFX, testing bug, build Windows .exe).

---

## Rincian Tugas Per Sesi Vibe Coding

### 🎯 Milestone 0: Fondasi Proyek Godot 4
- [ ] **Sesi 0.1:** Inisialisasi Project Settings Godot 4 (Display resolution 640x360, Stretch mode: viewport/canvas_items, Texture filtering: Nearest untuk pixel art).
- [ ] **Sesi 0.2:** Buat Autoload `GameState.gd` (Variabel global: player_stats, current_day, time_of_day, quest_flags, npc_reputation).
- [ ] **Sesi 0.3:** Buat Autoload `SceneManager.gd` untuk transisi antar ruangan (fade in/out hitam halus).

### 🎯 Milestone 1: Pergerakan & Lingkungan Awal
- [ ] **Sesi 1.1:** Buat Scene `Player.tscn` (CharacterBody2D, gerakan 4 arah top-down, collision box, animasi idle & jalan).
- [ ] **Sesi 1.2:** Buat TileMap / TileMapLayer untuk area interior: Kamar Kos Joko (`Room_Kost.tscn`).
- [ ] **Sesi 1.3:** Pasang `Camera2D` pada Player dengan batasan batas ruangan (Limits).
- [ ] **Sesi 1.4:** Buat komponen `InteractableArea.tscn` (Area2D dengan prompt tombol [E / Spasi] untuk kasur dan pintu).

### 🎯 Milestone 2: Sistem Dialog & Character Portrait
- [ ] **Sesi 2.1:** Buat UI `DialogueBox.tscn` (NinePatchRect panel, RichTextLabel efek mengetik/typewriter, Label nama karakter).
- [ ] **Sesi 2.2:** Integrasikan `TextureRect` untuk Character Portrait di samping teks dialog yang bisa berubah tekstur sesuai tag ekspresi (misal: `[portrait:bu_wati_galak]`).
- [ ] **Sesi 2.3:** Buat sistem pilihan dialog (Branching Choice Buttons) yang mengirimkan sinyal ke `GameState`.
- [ ] **Sesi 2.4:** Buat skrip pembaca file dialog sederhana (`DialogueManager.gd`) berbasis format JSON / Resource GDScript.

### 🎯 Milestone 3: Sistem Parameter (Survival Santai) & Waktu
- [ ] **Sesi 3.1:** Buat HUD bar di pojok kiri atas: Bar Energi, Lapar, Stres, dan tampilan Uang (Rp).
- [ ] **Sesi 3.2:** Hubungkan perubahan nilai di `GameState.gd` dengan pembaruan visual HUD menggunakan signal Godot.
- [ ] **Sesi 3.3:** Buat indikator jam/fase harian (Ikon Pagi ☀️, Siang 🌤️, Sore 🌅, Malam 🌙).
- [ ] **Sesi 3.4:** Mekanik tidur di kasur kos: cek apakah waktu sudah malam, reset energi ke 100, kurangi lapar, tambah hari +1, potong uang sewa jika jatuh tempo.

### 🎯 Milestone 4: Eksplorasi Luar & Jurnal Agenda
- [ ] **Sesi 4.1:** Buat map outdoor: `Street_Gang.tscn` (menghubungkan Kosan, Pos Ronda, dan Warkop Cak Man).
- [ ] **Sesi 4.2:** Buat UI `JournalUI.tscn` (buku catatan saku berisi daftar objektif aktif yang bisa dibuka/tutup dengan tombol [J / Tab]).
- [ ] **Sesi 4.3:** Tambahkan trigger pergantian fase waktu ketika pemain menyelesaikan tugas tertentu.

### 🎯 Milestone 5: Mini-Game Kerja & Street Clash Duel
- [ ] **Sesi 5.1:** Buat mini-game kerja serabutan: `MiniGame_PasarCargo.tscn` (mekanik menangkap kardus/menata barang sederhana, memberi imbalan uang Rp 25.000 dan menghabiskan 20 Energi).
- [ ] **Sesi 5.2:** Buat Scene `BattleClash.tscn` (tampilan 2D turn-based berhadapan: Sprite Joko vs Preman Pasar).
- [ ] **Sesi 5.3:** Logika giliran duel turn-based: tombol Pukul, Tangkis, Ngeles, dan Diplomasi (Ajak Damai/Beri Rokok/Kopi).
- [ ] **Sesi 5.4:** Feedback visual (Shake screen saat kena pukul, floating text damage/stres).

### 🎯 Milestone 6: Integrasi Demo & Finalisasi MVP
- [ ] **Sesi 6.1:** Pasang alur cerita Hari 1: Tiba di kos → Bertemu Bu Wati → Pergi ke warkop Cak Man → Tidur.
- [ ] **Sesi 6.2:** Pasang alur cerita Hari 2: Temani Bayu ke pasar → Kerja serabutan → Duel preman perdana.
- [ ] **Sesi 6.3:** Pasang alur cerita Hari 3: Evaluasi kondisi uang kos pertama.
- [ ] **Sesi 6.4:** Integrasi musik Lofi akustik & SFX (suara langkah kaki, interaksi dialog, jingle ganti hari).
- [ ] **Sesi 6.5:** Export build Windows (.exe) dan uji playtest tanpa crash.
