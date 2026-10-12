# Daftar Inventaris Aset & Lisensi Resmi (ASSET_LIST.md)
**Proyek:** *Langkah Pertama di Kota*  
**Engine:** Godot 4.x  
**Format Tile:** 16x16 / 32x32 Pixel Perfect  

---

## 1. Plugin & Addon Resmi (Dari Referensi User)
| Nama Plugin / Modul | Sumber Repository | Lisensi | Fungsi di Proyek |
|---|---|---|---|
| **Dialogue Manager** | [nathanhoad/godot_dialogue_manager](https://github.com/nathanhoad/godot_dialogue_manager) | MIT | Sistem percakapan, variabel dialog, dan event suara / portrait |
| **Phantom Camera** | [ramokz/phantom-camera](https://github.com/ramokz/phantom-camera) | MIT | Kontrol kamera 2D dinamis, zoom halus, pembatas dinding |

---

## 2. Aset Visual (Tileset & Karakter dari Repositori Resmi)
| Nama File Aset | Path di Proyek | Sumber Asli | Lisensi |
|---|---|---|---|
| `town_tilemap.png` | `res://assets/tilesets/town_tilemap.png` | [gdquest-demos/godot-open-rpg](https://github.com/gdquest-demos/godot-open-rpg) | CC-BY 4.0 (GDQuest) |
| `character_generic.png` | `res://assets/sprites/characters/character_generic.png` | [gdquest-demos/godot-open-rpg](https://github.com/gdquest-demos/godot-open-rpg) | CC-BY 4.0 (GDQuest) |
| `gobot_field.png` | `res://assets/sprites/characters/gobot_field.png` | [gdquest-demos/godot-open-rpg](https://github.com/gdquest-demos/godot-open-rpg) | CC-BY 4.0 (GDQuest) |
| `light_cookie.png` | `res://assets/sprites/props/light_cookie.png` | [godotengine/godot-demo-projects](https://github.com/godotengine/godot-demo-projects) | MIT (Godot Engine) |
| `font_main.otf` | `res://assets/ui/font_main.otf` | [godotengine/godot-demo-projects](https://github.com/godotengine/godot-demo-projects) | SIL Open Font License |

---

## 3. Sistem Atmosfer & Lighting (Godot 4 2D)
- **CanvasModulate:** Digunakan untuk memberi mood sore hari kekuningan / malam temaram (`Color(0.65, 0.62, 0.75, 1.0)`).
- **PointLight2D:** Menggunakan `light_cookie.png` untuk lampu jalan gang, lentera warkop, dan lampu bohlam kamar kos.
- **CPUParticles2D:** Efek uap panas kopi tubruk Cak Man dan debu jalanan sore.
