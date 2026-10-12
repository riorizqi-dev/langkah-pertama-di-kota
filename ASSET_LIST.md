# Daftar Inventaris Aset & Lisensi Resmi (ASSET_LIST.md)
**Proyek:** *Langkah Pertama di Kota*  
**Engine:** Godot 4.x  
**Format Tile & Resolusi Dasar:** 16x16 Pixel Art (`320x180` Viewport, Nearest Texture Filter)

---

## 1. Paket Aset Visual Utama (16x16 Pixel Art & UI Frame)
| Nama File Aset | Path di Proyek | Sumber Asli | Lisensi | Penggunaan |
|---|---|---|---|---|
| `kenney_urban_16x16.png` | `res://assets/tilesets/kenney_urban_16x16.png` | [Kenney Roguelike Modern City](https://kenney.nl/assets/roguelike-modern-city) | **CC0 1.0** (Public Domain) | Spritesheet karakter 4 arah (Joko, Bu Wati, Cak Man), lantai keramik, tembok bata, pintu, jendela, jemuran, kardus, warung, jalan aspal, lampu jalan |
| `kenney_indoor_16x16.png` | `res://assets/tilesets/kenney_indoor_16x16.png` | [Kenney Roguelike Indoors](https://kenney.nl/assets/roguelike-indoors) | **CC0 1.0** (Public Domain) | Furnitur interior kamar kos 16x16: kasur lipat, lemari pakaian, meja kayu, tanaman pot, dekorasi dinding |
| `kenney_ui_rpg.png` | `res://assets/ui/kenney_ui_rpg.png` | [Kenney UI Pack: RPG Expansion](https://kenney.nl/assets/ui-pack-rpg-expansion) | **CC0 1.0** (Public Domain) | Frame 9-patch tombol menu utama bergaya *Citampi Stories*, panel pengaturan, dan frame kotak dialog |
| `city_bg_back.png` | `res://assets/sprites/props/city_bg_back.png` | [roserha/city-parallax (OpenGameArt / GitHub)](https://github.com/roserha/city-parallax) | **CC0 / MIT** | Siluet gedung kota belakang pada latar malam Main Menu |
| `city_bg_front.png` | `res://assets/sprites/props/city_bg_front.png` | [roserha/city-parallax (OpenGameArt / GitHub)](https://github.com/roserha/city-parallax) | **CC0 / MIT** | Gedung bertingkat & menara jam pixel art pada latar malam Main Menu |
| `light_cookie.png` | `res://assets/sprites/props/light_cookie.png` | [godotengine/godot-demo-projects](https://github.com/godotengine/godot-demo-projects) | **MIT** (Godot Engine) | Tekstur pencahayaan `PointLight2D` lampu kamar kos, lampu jalan gang, dan lentera warkop |

---

## 2. Font Pixel & Audio (BGM / SFX)
| Nama File Aset | Path di Proyek | Sumber Asli | Lisensi | Penggunaan |
|---|---|---|---|---|
| `PixelifySans.ttf` | `res://assets/ui/PixelifySans.ttf` | [Google Fonts - Pixelify Sans](https://fonts.google.com/specimen/Pixelify+Sans) | **SIL Open Font License 1.1** | Tipografi judul utama *"Langkah Pertama di Kota"* pada Main Menu |
| `PressStart2P.ttf` | `res://assets/ui/PressStart2P.ttf` | [Google Fonts - Press Start 2P](https://fonts.google.com/specimen/Press+Start+2P) | **SIL Open Font License 1.1** | Font pixel untuk tombol menu, HUD, prompt interaksi `[E]`, dan teks dialog |
| `menu_theme.ogg` | `res://assets/audio/bgm/menu_theme.ogg` | [godotengine/godot-demo-projects](https://github.com/godotengine/godot-demo-projects) | **MIT** (Godot Engine) | Musik latar ambient pada Main Menu |
| `ui_click.wav` | `res://assets/audio/sfx/ui_click.wav` | [godotengine/godot-demo-projects](https://github.com/godotengine/godot-demo-projects) | **MIT** (Godot Engine) | Efek suara navigasi & klik tombol UI |

---

## 3. Plugin & Addon Resmi
| Nama Plugin / Modul | Sumber Repository | Lisensi | Fungsi di Proyek |
|---|---|---|---|
| **Dialogue Manager** | [nathanhoad/godot_dialogue_manager](https://github.com/nathanhoad/godot_dialogue_manager) | **MIT** | Sistem manajemen dialog dan naskah percakapan |
| **Phantom Camera** | [ramokz/phantom-camera](https://github.com/ramokz/phantom-camera) | **MIT** | Utilitas kamera 2D |
