# Struktur Folder Proyek & Rekomendasi Ekosistem Godot 4 (PROJECT_STRUCTURE.md)
**Proyek:** *Langkah Pertama di Kota*  
**Engine:** Godot Engine 4.x (Standard GDScript build)  

---

## 1. Usulan Struktur Folder Proyek (`res://`)
Struktur folder ini dirancang bersih, terpisah berdasarkan fungsionalitas aset dan scene, agar mudah dikembangkan bersama AI tanpa risiko file tercecer.

```text
res://
├── assets/
│   ├── audio/
│   │   ├── bgm/                  # Musik latar Lofi akustik (.ogg / .wav)
│   │   └── sfx/                  # Efek suara langkah kaki, jingle, klik UI (.wav)
│   ├── sprites/
│   │   ├── characters/           # Spritesheet jalan 4 arah (player, bu_wati, cak_man, dll)
│   │   ├── portraits/            # Portrait wajah dialog ekspresif 32-bit (.png)
│   │   └── props/                # Objek dekorasi (kasur, gerobak warkop, meja)
│   ├── tilesets/                 # Image tileset kota, interior kos, dan pasar (.png)
│   └── ui/                       # Texture kotak dialog, icon baterai/energi, jam, dll
│
├── scenes/
│   ├── characters/               # Scene karakter: player.tscn, npc_base.tscn
│   ├── maps/                     # Scene ruangan & area luar:
│   │   ├── room_kost.tscn        # Kamar kos Joko
│   │   ├── street_gang.tscn      # Gang rukun & pos ronda
│   │   └── market_district.tscn  # Area pasar & warkop
│   ├── minigames/                # Minigame serabutan & battle clash:
│   │   ├── pasar_cargo.tscn      # Minigame susun barang pasar
│   │   └── street_clash.tscn     # Duel turn-based santai
│   └── ui/                       # Scene antarmuka:
│       ├── hud.tscn              # Status bar energi, lapar, uang, jam
│       ├── dialogue_box.tscn     # Kotak dialog + portrait texture
│       ├── journal_ui.tscn       # Buku agenda tugas ala GTA
│       └── scene_transition.tscn # Layar fade hitam transisi antar ruangan
│
├── scripts/
│   ├── autoloads/                # Global Singletons:
│   │   ├── game_state.gd         # State uang, energi, hari, quest flags
│   │   └── scene_manager.gd      # Handler ganti map dengan fade in/out
│   ├── characters/               # player.gd, npc_dialogue.gd
│   ├── systems/                  # dialogue_manager.gd, quest_system.gd
│   └── ui/                       # hud_controller.gd, dialogue_box_controller.gd
│
├── data/
│   ├── dialogues/                # File skrip percakapan (JSON / Custom Resource)
│   └── quests/                   # Data definisi quest & objektif harian
│
└── project.godot                 # File konfigurasi utama proyek Godot
```

---

## 2. Pengaturan Project Godot 4 yang Direkomendasikan
Sebelum mulai mengimpor aset dan ngoding, lakukan konfigurasi ini di **Project -> Project Settings**:

1. **Display -> Window:**
   - **Viewport Width:** `640`
   - **Viewport Height:** `360` (Aspect ratio 16:9 pixel-perfect modern, terasa pas untuk gaya 32-bit)
   - **Window Width Override:** `1280` atau `1920` (Agar preview di monitor terlihat tajam dan pas)
   - **Stretch Mode:** `canvas_items` (atau `viewport`)
   - **Stretch Aspect:** `keep`
2. **Rendering -> Textures:**
   - **Default Texture Filter:** `Nearest` (Wajib untuk Pixel Art agar tidak buram / blur saat di-zoom)

---

## 3. Daftar Plugin & Addon Godot 4 yang Direkomendasikan

| Plugin / Tool | Sumber | Alasan Direkomendasikan |
|---|---|---|
| **Dialogic 2.0 (Opsional)** | [GitHub Dialogic](https://github.com/dialogic-godot/dialogic) | Jika ingin visual editor cabang dialog yang kaya fitur lengkap dengan penempatan portrait otomatis. *(Catatan: Untuk MVP awal, kita bisa pakai sistem script dialog custom ringan buatan AI agar pemula tidak bingung config addon)*. |
| **Phantom Camera** | [GitHub Phantom Camera](https://github.com/ramok-tech/phantom-camera) | Sangat memudahkan pengaturan kamera 2D yang mengikuti player, zoom dinamis saat dialog, dan pembatasan batas dinding ruangan tanpa pusing nulis math kamera manual. |
| **Aseprite Importer (Jika buat sprite sendiri)** | Godot AssetLib | Memungkinkan ekspor langsung file `.aseprite` menjadi `SpriteFrames` otomatis di Godot 4. |

---

## 4. Langkah Memulai Sesi Pertama
Ketika kamu sudah membuka Godot 4 dan membuat proyek baru di folder ini:
1. Kita akan langsung menjalankan **Sesi 0.1 & Sesi 0.2 dari `ROADMAP.md`**: Mengatur setting pixel art dan membuat file `GameState.gd` pertama kita.
