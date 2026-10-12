extends Node2D

## Scene Kamar Kos Joko 3x3m (Langkah 3 & 4)
## Menggunakan TileMapLayer dengan tileset Kenney 16x16 asli, Y-Sort, Collision, dan Interaksi [E].

const URBAN_TILES_PATH: String = "res://assets/tilesets/kenney_urban_16x16.png"

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
	ts.tile_size = Vector2i(16, 16)
	var src := TileSetAtlasSource.new()
	src.texture = load(URBAN_TILES_PATH)
	src.texture_region_size = Vector2i(16, 16)
	ts.add_source(src, 0)
	
	for tx in range(27):
		for ty in range(18):
			src.create_tile(Vector2i(tx, ty))
			
	bg_layer.tile_set = ts
	room_tile_map.tile_set = ts
	
	# Area gelap di luar tembok kamar kos (-12..11, -8..7)
	bg_layer.modulate = Color(0.18, 0.2, 0.28, 1.0)
	for x in range(-12, 12):
		for y in range(-8, 8):
			bg_layer.set_cell(Vector2i(x, y), 0, Vector2i(9, 1))
			
	var deco_layer := TileMapLayer.new()
	deco_layer.tile_set = ts
	room_tile_map.add_child(deco_layer)
	
	# Tembok atas kamar kos (x = -5..4, y = -4..-3)
	for x in range(-5, 5):
		room_tile_map.set_cell(Vector2i(x, -4), 0, Vector2i(18, 4)) # Atap/Batas tembok atas
		room_tile_map.set_cell(Vector2i(x, -3), 0, Vector2i(18, 6)) # Dinding tembok bata dalam
	# Jendela kamar kos di tembok atas (overlay di atas bata)
	deco_layer.set_cell(Vector2i(-3, -3), 0, Vector2i(11, 13))
	deco_layer.set_cell(Vector2i(2, -3), 0, Vector2i(11, 13))
	
	# Lantai keramik krem hangat kamar kos 3x3m (x = -5..4, y = -2..3)
	for x in range(-5, 5):
		for y in range(-2, 4):
			var tx: int = 1
			var ty: int = 4
			if x == -5 and y == -2:
				tx = 0; ty = 3
			elif x == 4 and y == -2:
				tx = 2; ty = 3
			elif x == -5 and y == 3:
				tx = 0; ty = 5
			elif x == 4 and y == 3:
				tx = 2; ty = 5
			elif y == -2:
				tx = 1; ty = 3
			elif y == 3:
				tx = 1; ty = 5
			elif x == -5:
				tx = 0; ty = 4
			elif x == 4:
				tx = 2; ty = 4
			room_tile_map.set_cell(Vector2i(x, y), 0, Vector2i(tx, ty))
			
	# Dinding pembatas kiri, kanan, dan bawah kamar
	for y in range(-4, 5):
		room_tile_map.set_cell(Vector2i(-6, y), 0, Vector2i(18, 6))
		room_tile_map.set_cell(Vector2i(5, y), 0, Vector2i(18, 6))
	for x in range(-6, 6):
		room_tile_map.set_cell(Vector2i(x, 4), 0, Vector2i(18, 7))

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
			"text": "Rebahan di kasur tipis kosan... Badan kembali segar dan waktu berganti ke hari berikutnya!"
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
			"text": "Meja kayu kecil dan tanaman pot... Pikiran jadi sedikit lebih tenang (Stres -5)."
		}
	])
	GameState.modify_stress(-5)

func _on_dispenser_interacted() -> void:
	dialogue_box.start_dialogue([
		{
			"speaker": "Joko",
			"text": "Minum air putih dari galon kosan... Segar! (Lapar +5)."
		}
	])
	GameState.modify_hunger(5)

func _on_wardrobe_interacted() -> void:
	dialogue_box.start_dialogue([
		{
			"speaker": "Joko",
			"text": "Lemari kayu kosan berisi baju ganti dari kampung dan catatan utang keluarga yang harus dilunasi."
		}
	])
