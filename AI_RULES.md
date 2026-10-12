# Panduan Aturan & Konvensi AI Vibe Coding (AI_RULES.md)
**Proyek:** *Langkah Pertama di Kota*  
**Engine:** Godot 4.x (GDScript)  
**Dokumen ini adalah KONTRAK KERJA MUTLAK bagi AI saat membantu proses koding dan penyusunan scene di proyek ini.**

---

## 1. Aturan Emas Kolaborasi (Golden Rules)
1. **Satu Sesi, Satu Fitur Kecil:** Jangan pernah mengimplementasikan beberapa modul besar sekaligus dalam satu respon. Selesaikan satu sub-tugas kecil dari `ROADMAP.md` sampai tuntas dan teruji.
2. **Jelaskan Sebelum dan Sesudah Menulis Kode:** Berikan ringkasan apa yang diubah, file mana saja yang disentuh, dan langkah persis yang harus dilakukan pengguna di Godot Editor (misal: "Assign node ini ke inspector").
3. **Surgical Changes (Jangan Rusak Kode Lain):** Ubah hanya file yang ditugaskan. Dilarang melakukan refactor sembarangan atau mengganti struktur file yang sudah berfungsi tanpa instruksi eksplisit dari pengguna.
4. **No Premature Over-Engineering:** Tulis GDScript yang bersih, mudah dibaca, dan modular. Hindari pola desain rumit jika Node, Signal, dan Resource standar Godot sudah cukup menyelesaikannya.

---

## 2. Standar Konvensi GDScript & Godot 4

### 2.1 Gaya Penamaan (Naming Conventions)
- **Nama File & Folder:** Gunakan `snake_case` (contoh: `player.gd`, `game_state.gd`, `dialogue_box.tscn`, `res://scenes/characters/`).
- **Nama Class / Types:** Gunakan `PascalCase` (contoh: `class_name CharacterPlayer`).
- **Nama Variabel & Fungsi:** Gunakan `snake_case` (contoh: `var current_stamina: int = 100`, `func update_quest_progress() -> void:`).
- **Nama Konstanta:** Gunakan `ALL_CAPS` (contoh: `const MAX_ENERGY: int = 100`).
- **Nama Signal:** Gunakan bentuk lampau atau aksi `snake_case` (contoh: `signal stamina_changed(new_value)`, `signal dialogue_completed`).

### 2.2 Pola Node & Typing
- Selalu gunakan **Static Typing** di GDScript untuk mencegah bug runtime (contoh: `var money: int = 50000`, `func add_money(amount: int) -> void:`).
- Gunakan `@onready var` untuk mereferensikan child node dalam scene lokal, bukan `get_node()` manual berulang kali.

---

## 3. Arsitektur Pola Desain Game

### 3.1 Autoload Tunggal untuk State (`GameState.gd`)
Seluruh status global pemain, kalender hari, uang, reputasi NPC, dan flag cerita disimpan di `res://scripts/autoloads/game_state.gd`.
- Dilarang menyimpan status penting game secara lokal di scene level atau scene player agar data tidak hilang saat berpindah ruangan/scene.
- Komponen lain mengakses state melalui pemanggilan aman:
  ```gdscript
  GameState.add_money(25000)
  GameState.decrease_energy(15)
  ```

### 3.2 Pola Event-Driven Menggunakan Signal
- `GameState` memancarkan signal ketika ada nilai yang berubah (misal: `signal stats_updated`).
- UI/HUD mendengarkan signal tersebut dan memperbarui tampilannya secara otomatis tanpa harus melakukan polling di `_process(delta)`.

### 3.3 Perpindahan Ruangan (`SceneManager.gd`)
- Semua pergantian scene dikendalikan oleh autoload `SceneManager.gd` menggunakan animasi overlay fade-in / fade-out untuk menjaga kehalusan transisi pixel art.

---

## 4. Panduan Respon AI kepada Pengguna
Setiap kali AI membuat atau memodifikasi script untuk pengguna, AI wajib menyertakan format berikut:
1. **Target File:** Lokasi path absolut dan relatif (contoh: `res://scripts/characters/player.gd`).
2. **Konteks Perubahan:** Alasan mengapa kode ini dibuat dan hubungannya dengan tugas di `ROADMAP.md`.
3. **Instruksi Godot Editor:** Langkah klik visual jika ada (misal: "Buka tab Node, hubungkan signal `body_entered` ke script ini").
4. **Cara Uji:** Langkah verifikasi singkat (contoh: "Tekan F5, coba gerakkan karakter pakai WASD, pastikan bar stamina berkurang saat menekan Shift").
