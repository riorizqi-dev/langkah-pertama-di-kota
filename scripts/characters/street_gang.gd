extends Node2D

## Scene Gang Depan Kosan & Warkop Cak Man (32x32 Shaded Modern Exteriors & Interiors)
## Dibangun menggunakan TileMapLayer 32x32 dengan modern_room_builder_32x32.png + karakter 32x48 beranimasi.

const ROOM_BUILDER_PATH: String = "res://assets/tilesets/modern_room_builder_32x32.png"

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
	ts.tile_size = Vector2i(32, 32)
	var src := TileSetAtlasSource.new()
	src.texture = load(ROOM_BUILDER_PATH)
	src.texture_region_size = Vector2i(32, 32)
	ts.add_source(src, 0)
	
	for tx in range(17):
		for ty in range(23):
			src.create_tile(Vector2i(tx, ty))
			
	street_tile_map.tile_set = ts
	
	# Langit / Latar atas gang (y = -6..-5)
	for x in range(-11, 11):
		for y in range(-6, -4):
			street_tile_map.set_cell(Vector2i(x, y), 0, Vector2i(12, 0))
			
	# Bangunan Kos Bu Wati (kiri: x = -11..-2, y = -3..-2) - Dinding Bata Merah 32x32
	for x in range(-11, -1):
		street_tile_map.set_cell(Vector2i(x, -4), 0, Vector2i(12, 0))
		street_tile_map.set_cell(Vector2i(x, -3), 0, Vector2i(5, 15))
		street_tile_map.set_cell(Vector2i(x, -2), 0, Vector2i(8, 16))
		
	# Bangunan Ruko & Warkop Cak Man (kanan: x = -1..10, y = -3..-2) - Dinding Ruko Modern 32x32
	for x in range(-1, 11):
		street_tile_map.set_cell(Vector2i(x, -4), 0, Vector2i(12, 0))
		street_tile_map.set_cell(Vector2i(x, -3), 0, Vector2i(5, 17))
		street_tile_map.set_cell(Vector2i(x, -2), 0, Vector2i(8, 18))
		
	# Trotoar Beton & Teras Kosan/Warkop (y = -1..0)
	for x in range(-11, 11):
		for y in range(-1, 1):
			if (x >= -6 and x <= -5 and y == -1) or (x >= 2 and x <= 5 and y == -1):
				# Teras keramik terakota di depan pintu kos & warkop
				street_tile_map.set_cell(Vector2i(x, y), 0, Vector2i(11 + (abs(x) % 2), 5))
			else:
				var sw_col: int = 11 + (abs(x + y) % 2)
				street_tile_map.set_cell(Vector2i(x, y), 0, Vector2i(sw_col, 11))
				
	# Jalan Aspal Kota (y = 1..4)
	for x in range(-11, 11):
		for y in range(1, 5):
			var rd_col: int = 14 + (abs(x) % 2)
			var rd_row: int = 11 + (abs(y) % 2)
			street_tile_map.set_cell(Vector2i(x, y), 0, Vector2i(rd_col, rd_row))

func _update_lighting_by_time() -> void:
	match GameState.get_current_phase_name():
		"Pagi":
			canvas_modulate.color = Color(0.96, 0.95, 0.92, 1.0)
		"Siang":
			canvas_modulate.color = Color(1.0, 0.98, 0.95, 1.0)
		"Sore":
			canvas_modulate.color = Color(0.9, 0.78, 0.72, 1.0)
		"Malam":
			canvas_modulate.color = Color(0.5, 0.54, 0.74, 1.0)

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
