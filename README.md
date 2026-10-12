# Langkah Pertama di Kota — 2D Pixel Art Narrative RPG (Godot 4)

Game naratif *Slice of Life* 2D Pixel Art tentang perjuangan Joko, pemuda perantau baru yang berusaha melunasi utang keluarga dan beradaptasi dengan kehidupan gang kota, kos-kosan Bu Wati, dan Warkop Cak Man.

---

## Fitur Tahap 1 (Main Menu & Fondasi Vertikal)
- **Main Menu Interaktif (`res://scenes/ui/main_menu.tscn`):**
  - Navigasi langsung ke mode cerita (*Mulai Merantau*) atau mode latihan duel (*Lawan Maling Jemuran*).
  - Panel profil karakter Joko, diorama warkop, modal *Panduan & Cerita*, serta *Pengaturan Layar* (Fullscreen toggle).
  - Transisi layar *Fade-In / Fade-Out* halus & partikel kunang-kunang senja.
- **Kamar Kos & Gang Kota (`room_kost.tscn` & `street_gang.tscn`):**
  - Pergerakan 4 arah top-down pixel-perfect (`480x270` Nearest filter).
  - Sistem status survival santai (`GameState.gd`): Uang (Rp), Energi, Lapar, Stres, dan Siklus Waktu Harian.
  - Pencahayaan `PointLight2D` lentera warkop, `CanvasModulate` sore hari, dan partikel uap kopi.
- **Turn-Based Street Clash (`battle_screen.tscn`):**
  - Sistem pertarungan kasual lawan Maling Jemuran dengan aksi *Serang*, *Isi MP*, *Bakpia*, *Ayam Geprek*, *Oseng Mercon*, *Mundur*, dan *Lewati*.

---

## Dokumen Perencanaan
- [`GDD.md`](./GDD.md) — Game Design Document
- [`STORY.md`](./STORY.md) — Sinopsis, Profil Karakter & Dialog Kunci
- [`ROADMAP.md`](./ROADMAP.md) — Milestone & Checklist Vibe Coding
- [`ASSET_LIST.md`](./ASSET_LIST.md) — Inventaris Aset & Lisensi Resmi
- [`AI_RULES.md`](./AI_RULES.md) — Panduan Arsitektur & Konvensi GDScript
- [`PROJECT_STRUCTURE.md`](./PROJECT_STRUCTURE.md) — Struktur Folder Proyek
