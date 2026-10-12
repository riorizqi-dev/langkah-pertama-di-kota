extends Node2D

## Scene Gang Depan Kosan & Warkop Cak Man (Langkah 3 & 4)
## Dibangun menggunakan TileMapLayer dengan tileset Kenney Urban 16x16 asli.

const URBAN_TILES_PATH: String = "res://assets/tilesets/kenney_urban_16x16.png"

@onready var street_tile_map: TileMapLayer = $StreetTileMap
@onready var canvas_modulate: CanvasModulate = $CanvasModulateSore
@onready var dialogue_box: DialogueBoxController = $DialogueBox
@onready var hud: CanvasLayer = $HUD

func _ready() -> void:
	_build_street_tilemap()
	_update_lighting_by_time()
	GameState.time_changed.connect(_on_time_changed)

func _on_time_changed(_day: int, _phase: String) -> void:
	_update_lighting_by_time()

func _build_street_tilemap() -> void:
	var ts := TileSet.new()
	ts.tile_size = Vector2i(16, 16)
	var src := TileSetAtlasSource.new()
	src.texture = load(URBAN_TILES_PATH)
	src.texture_region_size = Vector2i(16, 16)
	ts.add_source(src, 0)
	
	for tx in range(27):
		for ty in range(18):
			src.create_tile(Vector2i(tx, ty))
			
	street_tile_map.tile_set = ts
	
	# Langit / Latar atas gang (y = -6..-5)
	for x in range(-11, 11):
		for y in range(-6, -4):
			street_tile_map.set_cell(Vector2i(x, y), 0, Vector2i(9, 1))
			
	var deco_layer := TileMapLayer.new()
	deco_layer.tile_set = ts
	street_tile_map.add_child(deco_layer)
	
	# Bangunan Kos Bu Wati (kiri: x = -11..-2, y = -5..-2) - Bata Merah
	for x in range(-11, -1):
		street_tile_map.set_cell(Vector2i(x, -5), 0, Vector2i(18, 0))
		street_tile_map.set_cell(Vector2i(x, -4), 0, Vector2i(18, 2))
		street_tile_map.set_cell(Vector2i(x, -3), 0, Vector2i(18, 2))
		street_tile_map.set_cell(Vector2i(x, -2), 0, Vector2i(18, 3))
	deco_layer.set_cell(Vector2i(-9, -3), 0, Vector2i(11, 13))
	deco_layer.set_cell(Vector2i(-5, -3), 0, Vector2i(11, 13))
	deco_layer.set_cell(Vector2i(-3, -3), 0, Vector2i(11, 13))
	
	# Bangunan Ruko & Warung (kanan: x = -1..10, y = -5..-2) - Bata Cokelat
	for x in range(-1, 11):
		street_tile_map.set_cell(Vector2i(x, -5), 0, Vector2i(18, 4))
		street_tile_map.set_cell(Vector2i(x, -4), 0, Vector2i(18, 6))
		street_tile_map.set_cell(Vector2i(x, -3), 0, Vector2i(18, 6))
		street_tile_map.set_cell(Vector2i(x, -2), 0, Vector2i(18, 7))
	deco_layer.set_cell(Vector2i(1, -3), 0, Vector2i(12, 13))
	deco_layer.set_cell(Vector2i(4, -3), 0, Vector2i(12, 13))
	deco_layer.set_cell(Vector2i(8, -3), 0, Vector2i(12, 13))
	deco_layer.set_cell(Vector2i(2, -2), 0, Vector2i(14, 10))
	
	# Trotoar Gang Kosan (y = -1..1)
	for x in range(-11, 11):
		street_tile_map.set_cell(Vector2i(x, -1), 0, Vector2i(9, 3))
		street_tile_map.set_cell(Vector2i(x, 0), 0, Vector2i(9, 4))
		street_tile_map.set_cell(Vector2i(x, 1), 0, Vector2i(9, 5))
		
	# Jalan Aspal Kota & Zebra Cross (y = 2..5)
	for x in range(-11, 11):
		for y in range(2, 6):
			if x == -2 or x == -1:
				street_tile_map.set_cell(Vector2i(x, y), 0, Vector2i(0, 16))
			elif y == 2:
				street_tile_map.set_cell(Vector2i(x, y), 0, Vector2i(1, 15))
			elif y == 5:
				street_tile_map.set_cell(Vector2i(x, y), 0, Vector2i(1, 17))
			else:
				street_tile_map.set_cell(Vector2i(x, y), 0, Vector2i(1, 16))

func _update_lighting_by_time() -> void:
	match GameState.get_current_phase_name():
		"Pagi":
			canvas_modulate.color = Color(0.96, 0.95, 0.92, 1.0)
		"Siang":
			canvas_modulate.color = Color(1.0, 0.98, 0.95, 1.0)
		"Sore":
			canvas_modulate.color = Color(0.88, 0.76, 0.72, 1.0)
		"Malam":
			canvas_modulate.color = Color(0.48, 0.52, 0.72, 1.0)

func _on_bu_wati_interacted() -> void:
	if not GameState.get_flag("has_talked_to_bu_wati"):
		dialogue_box.start_dialogue([
			{
				"speaker": "Bu Wati (Ibu Kos)",
				"text": "Kamu Joko anak perantau baru di kamar nomor 3 kan? Jangan lupa uang sewa Rp 350.000 bulan ini!"
			},
			{
				"speaker": "Joko",
				"text": "I-iya, Bu Wati. Hari ini saya mau langsung cari kerja serabutan."
			},
			{
				"speaker": "Bu Wati (Ibu Kos)",
				"text": "Coba tanya Cak Man di warkop sebelah kanan itu, biasanya dia tahu kerjaan angkut barang."
			}
		])
		GameState.set_flag("has_talked_to_bu_wati", true)
	else:
		dialogue_box.start_dialogue([
			{
				"speaker": "Bu Wati (Ibu Kos)",
				"text": "Ayo rajin kerja di kota! Kalau lapar atau butuh kerjaan, mampir ke Warkop Cak Man di kanan."
			}
		])

func _on_warkop_interacted() -> void:
	dialogue_box.start_dialogue([
		{
			"speaker": "Cak Man",
			"text": "Monggo Mas Joko! Kebetulan warung lagi butuh bantuan angkut krat barang dari pasar."
		},
		{
			"speaker": "Joko",
			"text": "Siap Cak Man! Saya bantu angkut sekarang."
		},
		{
			"speaker": "Cak Man",
			"text": "Mantap! Ini upah Rp 25.000 ditambah kopi hangat buat nambah semangat!"
		}
	])
	dialogue_box.dialogue_finished.connect(func():
		GameState.add_money(25000)
		GameState.modify_energy(-20)
		GameState.advance_time_phase()
	, CONNECT_ONE_SHOT)

func _on_door_back_interacted() -> void:
	get_tree().change_scene_to_file("res://scenes/maps/room_kost.tscn")
