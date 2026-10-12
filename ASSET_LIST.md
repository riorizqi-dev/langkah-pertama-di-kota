# Daftar Inventaris Aset & Lisensi Resmi (ASSET_LIST.md)
**Proyek:** *Langkah Pertama di Kota*  
**Engine:** Godot 4.x  
**Format Tile & Resolusi Dasar:** 32x32 Shaded Modern Pixel Art (`960x540` Base Resolution, `canvas_items` Stretch Mode, Nearest World Texture Filter, Sharp Screen-Resolution UI & Fonts)

---

## 1. Paket Aset Visual Utama (32x32 Modern Interiors / Exteriors & Karakter 32x48)
| Nama File Aset | Path di Proyek | Sumber Asli | Lisensi | Penggunaan |
|---|---|---|---|---|
| `modern_room_builder_32x32.png` | `res://assets/tilesets/modern_room_builder_32x32.png` | [LimeZu Modern Interiors - Room Builder 32x32 (itch.io)](https://limezu.itch.io/moderninteriors) | **Free Version / Standard Asset License (LimeZu)** | Tileset 32x32 lantai keramik krem, parket kayu, terakota, trotoar beton, jalan aspal kota, tembok kamar kos ber-baseboard, dinding bata merah, dan dinding ruko modern |
| `modern_interiors_32x32.png` | `res://assets/tilesets/modern_interiors_32x32.png` | [LimeZu Modern Interiors 32x32 (itch.io)](https://limezu.itch.io/moderninteriors) | **Free Version / Standard Asset License (LimeZu)** | Furnitur & properti 32x32 ber-shading: kasur kosan, lemari kayu 2 pintu, meja belajar & lampu duduk, jendela bergorden, pintu kayu kos, karpet tenun, kardus pindahan, ember & pel, rak warung, meja kasir warkop, bangku taman |
| `modern_props_32x32.png` | `res://assets/tilesets/modern_props_32x32.png` | [LimeZu Modern Interiors Props 32x32 (itch.io)](https://limezu.itch.io/moderninteriors) | **Free Version / Standard Asset License (LimeZu)** | Properti modern 32x32 dengan bayangan: dispenser air galon, kipas/AC dinding kamar kos, kulkas minuman dingin warkop |
| `modern_exterior_32x32.png` | `res://assets/tilesets/modern_exterior_32x32.png` | [LimeZu Modern Exteriors / Gatherer Exterior 32x32](https://limezu.itch.io/modernexteriors) | **CC-BY 4.0 / Standard Asset License** | Pohon rindang 32x32 ber-shading, pohon berbunga, dan semak belukar di gang depan kosan |
| `modern_generic_32x32.png` | `res://assets/tilesets/modern_generic_32x32.png` | [LimeZu Modern Interiors Generic 32x32 (itch.io)](https://limezu.itch.io/moderninteriors) | **Free Version / Standard Asset License (LimeZu)** | Cadangan properti interior & toko modern 32x32 |
| `modern_floors_walls_32x32.png` | `res://assets/tilesets/modern_floors_walls_32x32.png` | [LimeZu Modern Floors & Walls 32x32 (itch.io)](https://limezu.itch.io/moderninteriors) | **Free Version / Standard Asset License (LimeZu)** | Variasi lantai dan tembok modern 32x32 |
| `joko_32x48.png` | `res://assets/sprites/characters/joko_32x48.png` | [LimeZu Modern Character Generator 32x48 (itch.io)](https://limezu.itch.io/moderninteriors) | **Free Version / Standard Asset License (LimeZu)** | Spritesheet karakter utama Joko (`32x48`, 52 frame: 6 frame `idle` x 4 arah + 6 frame `walk` x 4 arah dengan shading halus) |
| `bu_wati_32x48.png` | `res://assets/sprites/characters/bu_wati_32x48.png` | [LimeZu Modern Character Generator 32x48 (itch.io)](https://limezu.itch.io/moderninteriors) | **Free Version / Standard Asset License (LimeZu)** | Spritesheet NPC Bu Wati / Ibu Kos (`32x48`, animasi `idle_down` 6 frame ber-shading) |
| `cak_man_32x48.png` | `res://assets/sprites/characters/cak_man_32x48.png` | [LimeZu Modern Character Generator 32x48 (itch.io)](https://limezu.itch.io/moderninteriors) | **Free Version / Standard Asset License (LimeZu)** | Spritesheet NPC Cak Man penjaga warkop (`32x48`, animasi `idle_down` 6 frame ber-shading) |
| `warga_32x48.png` | `res://assets/sprites/characters/warga_32x48.png` | [LimeZu Modern Character Generator 32x48 (itch.io)](https://limezu.itch.io/moderninteriors) | **Free Version / Standard Asset License (LimeZu)** | Spritesheet NPC warga sekitar (`32x48`, 52 frame) |
| `city_bg_back.png` | `res://assets/sprites/props/city_bg_back.png` | [roserha/city-parallax (OpenGameArt / GitHub)](https://github.com/roserha/city-parallax) | **CC0 / MIT** | Siluet gedung kota belakang pada latar malam Main Menu |
| `city_bg_front.png` | `res://assets/sprites/props/city_bg_front.png` | [roserha/city-parallax (OpenGameArt / GitHub)](https://github.com/roserha/city-parallax) | **CC0 / MIT** | Gedung bertingkat & menara jam pixel art pada latar malam Main Menu |
| `light_cookie.png` | `res://assets/sprites/props/light_cookie.png` | [godotengine/godot-demo-projects](https://github.com/godotengine/godot-demo-projects) | **MIT** (Godot Engine) | Tekstur pencahayaan `PointLight2D` lampu kamar kos, cahaya matahari jendela, lampu jalan gang, lentera warkop, serta bayangan elips lembut di bawah karakter dan objek |
| `kenney_ui_rpg.png` | `res://assets/ui/kenney_ui_rpg.png` | [Kenney UI Pack: RPG Expansion](https://kenney.nl/assets/ui-pack-rpg-expansion) | **CC0 1.0** (Public Domain) | Tekstur latar transisi layar (FadeLayer) |

---

## 2. Font Tajam (Vector UI) & Audio (BGM / SFX)
| Nama File Aset | Path di Proyek | Sumber Asli | Lisensi | Penggunaan |
|---|---|---|---|---|
| `montserrat_extra_bold.otf` | `res://assets/ui/montserrat_extra_bold.otf` | [Google Fonts - Montserrat](https://fonts.google.com/specimen/Montserrat) | **SIL Open Font License 1.1** | Tipografi tajam untuk judul utama *"Langkah Pertama di Kota"*, tombol menu, indikator waktu/uang HUD, dan nama pembicara dialog |
| `font_main.otf` | `res://assets/ui/font_main.otf` | [godotengine/godot-demo-projects](https://github.com/godotengine/godot-demo-projects) | **SIL Open Font License 1.1** | Font bersih & tajam untuk isi teks dialog, sub-judul, dan prompt interaksi `[E]` |
| `menu_theme.ogg` | `res://assets/audio/bgm/menu_theme.ogg` | [godotengine/godot-demo-projects](https://github.com/godotengine/godot-demo-projects) | **MIT** (Godot Engine) | Musik latar ambient pada Main Menu |
| `ui_click.wav` | `res://assets/audio/sfx/ui_click.wav` | [godotengine/godot-demo-projects](https://github.com/godotengine/godot-demo-projects) | **MIT** (Godot Engine) | Efek suara navigasi & klik tombol UI |

---

## 3. Plugin & Addon Resmi
| Nama Plugin / Modul | Sumber Repository | Lisensi | Fungsi di Proyek |
|---|---|---|---|
| **Dialogue Manager** | [nathanhoad/godot_dialogue_manager](https://github.com/nathanhoad/godot_dialogue_manager) | **MIT** | Sistem manajemen dialog dan naskah percakapan |
| **Phantom Camera** | [ramokz/phantom-camera](https://github.com/ramokz/phantom-camera) | **MIT** | Utilitas kamera 2D |
