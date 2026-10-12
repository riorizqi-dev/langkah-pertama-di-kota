extends Node2D

## Scene Kamar Kos Joko 3x3m (32x32 Shaded Modern Interiors)
## Menggunakan TileMapLayer 32x32 dengan modern_room_builder_32x32.png, Y-Sort, Bayangan Lembut, dan Interaksi [E].

const ROOM_BUILDER_PATH: String = "res://assets/tilesets/modern_room_builder_32x32.png"

@onready var bg_layer: TileMapLayer = $BackgroundLayer
@onready var room_tile_map: TileMapLayer = $RoomTileMap
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var player: Player = $YSortNodes/Player
@onready var dialogue_box: DialogueBoxController = $DialogueBox
@onready var hud: CanvasLayer = $HUD

func _ready() -> void:
	_build_room_tilemap()
	_update_lighting_by_time()
	GameState.time_changed.connect(_on_time_changed)
	
	if not GameState.get_flag("has_seen_intro"):
		GameState.set_flag("has_seen_intro", true)
		call_deferred("_trigger_intro_dialogue")

func _on_time_changed(_day: int, _phase: String) -> void:
	_update_lighting_by_time()

func _build_room_tilemap() -> void:
	var ts := TileSet.new()
	ts.tile_size = Vector2i(32, 32)
	var src := TileSetAtlasSource.new()
	src.texture = load(ROOM_BUILDER_PATH)
	src.texture_region_size = Vector2i(32, 32)
	ts.add_source(src, 0)
	
	for tx in range(17):
		for ty in range(23):
			src.create_tile(Vector2i(tx, ty))
			
	bg_layer.tile_set = ts
	room_tile_map.tile_set = ts
	
	# Area gelap di luar tembok kamar kos (-10..9, -6..6)
	bg_layer.modulate = Color(0.1, 0.12, 0.18, 1.0)
	for x in range(-10, 10):
		for y in range(-6, 7):
			bg_layer.set_cell(Vector2i(x, y), 0, Vector2i(12, 0))
			
	# Tembok atas kamar kos (x = -5..4, y = -4..-3) - Dinding Krem + Baseboard Kayu 32x32
	for x in range(-5, 5):
		room_tile_map.set_cell(Vector2i(x, -4), 0, Vector2i(5, 7))
		room_tile_map.set_cell(Vector2i(x, -3), 0, Vector2i(8, 8))
		
	# Lantai keramik krem hangat kamar kos 3x3m (x = -5..4, y = -2..3)
	for x in range(-5, 5):
		for y in range(-2, 4):
			if (x == -1 or x == 0) and y == -2:
				# Keset / Parket kayu di depan pintu kos
				room_tile_map.set_cell(Vector2i(x, y), 0, Vector2i(11 + abs(x % 2), 13))
			else:
				var col: int = 11 + (abs(x + y) % 2)
				var row: int = 7 + (abs(y) % 2)
				room_tile_map.set_cell(Vector2i(x, y), 0, Vector2i(col, row))
				
	# Dinding pembatas gelap di sekeliling luar kamar kos
	for y in range(-5, 5):
		room_tile_map.set_cell(Vector2i(-6, y), 0, Vector2i(12, 0))
		room_tile_map.set_cell(Vector2i(5, y), 0, Vector2i(12, 0))
	for x in range(-6, 6):
		room_tile_map.set_cell(Vector2i(x, -5), 0, Vector2i(12, 0))
		room_tile_map.set_cell(Vector2i(x, 4), 0, Vector2i(12, 0))

func _update_lighting_by_time() -> void:
	match GameState.get_current_phase_name():
		"Pagi":
			canvas_modulate.color = Color(0.96, 0.94, 0.9, 1.0)
		"Siang":
			canvas_modulate.color = Color(1.0, 0.98, 0.95, 1.0)
		"Sore":
			canvas_modulate.color = Color(0.92, 0.8, 0.72, 1.0)
		"Malam":
			canvas_modulate.color = Color(0.55, 0.58, 0.75, 1.0)

func _trigger_intro_dialogue() -> void:
	var intro: Array[Dictionary] = [
		{
			"speaker": "Joko",
			"text": "Kamar kos petak 3x3 meter... Sempit, tapi cukup buat mulai hidup baru di kota."
		},
		{
			"speaker": "Joko",
			"text": "Gunakan WASD/Panah untuk jalan, Shift untuk lari, dan [E] di dekat kasur, lemari, atau pintu."
		}
	]
	dialogue_box.start_dialogue(intro)

func _on_bed_interacted() -> void:
	var bed_dlg: Array[Dictionary] = [
		{
			"speaker": "Joko",
			"text": "Rebahan di kasur kosan... Badan kembali segar dan waktu berganti ke hari berikutnya!"
		}
	]
	dialogue_box.start_dialogue(bed_dlg)
	dialogue_box.dialogue_finished.connect(func():
		GameState.sleep_and_advance_day()
		_update_lighting_by_time()
	, CONNECT_ONE_SHOT)

func _on_door_interacted() -> void:
	var door_dlg: Array[Dictionary] = [
		{
			"speaker": "Joko",
			"text": "Membuka pintu kamar kos... Keluar menuju gang depan kosan."
		}
	]
	dialogue_box.start_dialogue(door_dlg)
	dialogue_box.dialogue_finished.connect(func():
		get_tree().change_scene_to_file("res://scenes/maps/street_gang.tscn")
	, CONNECT_ONE_SHOT)

func _on_fan_interacted() -> void:
	dialogue_box.start_dialogue([
		{
			"speaker": "Joko",
			"text": "Meja belajar kayu dengan lampu duduk dan tanaman hias... Pikiran jadi lebih tenang (Stres -5)."
		}
	])
	GameState.modify_stress(-5)

func _on_dispenser_interacted() -> void:
	dialogue_box.start_dialogue([
		{
			"speaker": "Joko",
			"text": "Minum air putih dari dispenser galon kosan... Segar! (Lapar +5)."
		}
	])
	GameState.modify_hunger(5)

func _on_wardrobe_interacted() -> void:
	dialogue_box.start_dialogue([
		{
			"speaker": "Joko",
			"text": "Lemari kayu dua pintu berisi baju ganti dari kampung dan catatan utang keluarga yang harus dilunasi."
		}
	])
