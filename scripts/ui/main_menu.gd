extends Control

## Main Menu Controller - Langkah Pertama di Kota (960x540, 32x32 Shaded Pixel Art)
## Hanya 4 tombol utama: Mulai Baru, Lanjutkan, Pengaturan, Keluar.
## Mendukung navigasi Keyboard (W/S/Panah + Enter) dan Mouse + SFX klik + BGM.

const ROOM_BUILDER_PATH: String = "res://assets/tilesets/modern_room_builder_32x32.png"

@onready var night_street_map: TileMapLayer = $BackgroundScene/NightStreetMap
@onready var btn_start: Button = $ButtonsVBox/BtnStart
@onready var btn_continue: Button = $ButtonsVBox/BtnContinue
@onready var btn_settings: Button = $ButtonsVBox/BtnSettings
@onready var btn_exit: Button = $ButtonsVBox/BtnExit
@onready var modal_settings: PanelContainer = $ModalSettings
@onready var check_fullscreen: CheckButton = $ModalSettings/VBox/HBoxFullscreen/CheckFullscreen
@onready var btn_close_settings: Button = $ModalSettings/VBox/BtnCloseSettings
@onready var bgm_player: AudioStreamPlayer = $BGMPlayer
@onready var sfx_player: AudioStreamPlayer = $SFXPlayer
@onready var fade_sprite: Sprite2D = $FadeLayer/FadeSprite

var _is_ready_sfx: bool = false

func _exit_tree() -> void:
	if bgm_player:
		bgm_player.stop()
		bgm_player.stream = null
	if sfx_player:
		sfx_player.stop()
		sfx_player.stream = null

func _ready() -> void:
	modal_settings.visible = false
	_build_night_street_tilemap()
	_setup_button_navigation()
	if DisplayServer.get_name() != "headless" and bgm_player:
		bgm_player.play()
	
	# Fade-in halus saat menu dibuka
	fade_sprite.modulate = Color(0, 0, 0, 1)
	fade_sprite.visible = true
	var tw: Tween = create_tween()
	tw.tween_property(fade_sprite, "modulate:a", 0.0, 0.45)
	tw.tween_callback(fade_sprite.hide)
	
	btn_start.grab_focus()
	_is_ready_sfx = true

func _build_night_street_tilemap() -> void:
	var ts := TileSet.new()
	ts.tile_size = Vector2i(32, 32)
	var src := TileSetAtlasSource.new()
	src.texture = load(ROOM_BUILDER_PATH)
	src.texture_region_size = Vector2i(32, 32)
	ts.add_source(src, 0)
	
	for tx in range(17):
		for ty in range(23):
			src.create_tile(Vector2i(tx, ty))
			
	night_street_map.tile_set = ts
	night_street_map.modulate = Color(0.78, 0.82, 0.94, 1.0)
	
	# Bangunan Kos Kiri (x = 0..5, y = 5..6) - Dinding Bata Merah 32x32
	for x in range(0, 6):
		night_street_map.set_cell(Vector2i(x, 4), 0, Vector2i(12, 0))
		night_street_map.set_cell(Vector2i(x, 5), 0, Vector2i(5, 15))
		night_street_map.set_cell(Vector2i(x, 6), 0, Vector2i(8, 16))
		
	# Bangunan Ruko Kanan (x = 10..15, y = 5..6) - Dinding Abu Modern 32x32
	for x in range(10, 16):
		night_street_map.set_cell(Vector2i(x, 4), 0, Vector2i(12, 0))
		night_street_map.set_cell(Vector2i(x, 5), 0, Vector2i(5, 17))
		night_street_map.set_cell(Vector2i(x, 6), 0, Vector2i(8, 18))
		
	# Trotoar Beton (y = 7) & Jalan Aspal Malam (y = 8)
	for x in range(0, 16):
		var sw_col: int = 11 if (x % 2 == 0) else 12
		night_street_map.set_cell(Vector2i(x, 7), 0, Vector2i(sw_col, 11))
		night_street_map.set_cell(Vector2i(x, 8), 0, Vector2i(14 + (x % 2), 11))

func _setup_button_navigation() -> void:
	var buttons: Array[Button] = [btn_start, btn_continue, btn_settings, btn_exit]
	for i in range(buttons.size()):
		var b: Button = buttons[i]
		var prev_btn: Button = buttons[(i - 1 + buttons.size()) % buttons.size()]
		var next_btn: Button = buttons[(i + 1) % buttons.size()]
		b.focus_neighbor_top = b.get_path_to(prev_btn)
		b.focus_neighbor_bottom = b.get_path_to(next_btn)
		b.focus_entered.connect(_play_click_sfx)
		b.mouse_entered.connect(_on_button_mouse_entered.bind(b))

func _on_button_mouse_entered(b: Button) -> void:
	if not modal_settings.visible:
		b.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
	if modal_settings.visible:
		if event.is_action_pressed("ui_cancel"):
			_on_btn_close_modal_pressed()
		return
	if event.is_action_pressed("move_up"):
		var f := get_viewport().gui_get_focus_owner()
		if f and f.focus_neighbor_top:
			var target := f.get_node_or_null(f.focus_neighbor_top) as Control
			if target:
				target.grab_focus()
				get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_down"):
		var f := get_viewport().gui_get_focus_owner()
		if f and f.focus_neighbor_bottom:
			var target := f.get_node_or_null(f.focus_neighbor_bottom) as Control
			if target:
				target.grab_focus()
				get_viewport().set_input_as_handled()

func _play_click_sfx() -> void:
	if _is_ready_sfx and sfx_player:
		sfx_player.play()

func _transition_to_scene(scene_path: String) -> void:
	_play_click_sfx()
	fade_sprite.visible = true
	fade_sprite.modulate = Color(0, 0, 0, 0)
	var tw: Tween = create_tween()
	tw.tween_property(fade_sprite, "modulate:a", 1.0, 0.35)
	tw.tween_callback(func():
		get_tree().change_scene_to_file(scene_path)
	)

func _on_btn_start_pressed() -> void:
	GameState.money = 50000
	GameState.energy = 100
	GameState.hunger = 80
	GameState.stress = 20
	GameState.current_day = 1
	GameState.current_time_index = 0
	GameState.story_flags.clear()
	_transition_to_scene("res://scenes/maps/room_kost.tscn")

func _on_btn_continue_pressed() -> void:
	_transition_to_scene("res://scenes/maps/room_kost.tscn")

func _on_btn_settings_pressed() -> void:
	_play_click_sfx()
	modal_settings.visible = true
	check_fullscreen.button_pressed = (DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN)
	btn_close_settings.grab_focus()

func _on_btn_close_modal_pressed() -> void:
	_play_click_sfx()
	modal_settings.visible = false
	btn_settings.grab_focus()

func _on_check_fullscreen_toggled(toggled_on: bool) -> void:
	_play_click_sfx()
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_btn_exit_pressed() -> void:
	_play_click_sfx()
	get_tree().quit()
