extends Control

## Main Menu Controller - Langkah Pertama di Kota
## Mengelola navigasi menu utama, modal pengaturan, modal panduan, dan transisi layar.

@onready var btn_start: Button = $MainLayout/LeftColumn/MenuCard/Margin/VBoxButtons/BtnStart
@onready var btn_battle: Button = $MainLayout/LeftColumn/MenuCard/Margin/VBoxButtons/BtnBattle
@onready var btn_guide: Button = $MainLayout/LeftColumn/MenuCard/Margin/VBoxButtons/BtnGuide
@onready var btn_settings: Button = $MainLayout/LeftColumn/MenuCard/Margin/VBoxButtons/BtnSettings
@onready var btn_exit: Button = $MainLayout/LeftColumn/MenuCard/Margin/VBoxButtons/BtnExit

@onready var modal_settings: PanelContainer = $ModalOverlay/ModalSettings
@onready var modal_guide: PanelContainer = $ModalOverlay/ModalGuide
@onready var modal_overlay: ColorRect = $ModalOverlay
@onready var fade_rect: ColorRect = $FadeLayer/FadeRect
@onready var check_fullscreen: CheckButton = $ModalOverlay/ModalSettings/Margin/VBox/HBoxFullscreen/CheckFullscreen

func _ready() -> void:
	modal_overlay.visible = false
	modal_settings.visible = false
	modal_guide.visible = false
	
	# Animasi Fade-In halus saat masuk Main Menu
	fade_rect.color = Color(0, 0, 0, 1)
	fade_rect.visible = true
	var tw: Tween = create_tween()
	tw.tween_property(fade_rect, "color:a", 0.0, 0.5)
	tw.tween_callback(func(): fade_rect.visible = false)
	
	btn_start.grab_focus()

func _transition_to_scene(scene_path: String) -> void:
	fade_rect.visible = true
	fade_rect.color = Color(0, 0, 0, 0)
	var tw: Tween = create_tween()
	tw.tween_property(fade_rect, "color:a", 1.0, 0.35)
	tw.tween_callback(func():
		get_tree().change_scene_to_file(scene_path)
	)

func _on_btn_start_pressed() -> void:
	# Reset status awal permainan baru
	GameState.money = 50000
	GameState.energy = 100
	GameState.hunger = 80
	GameState.stress = 20
	GameState.current_day = 1
	GameState.current_time_index = 0
	_transition_to_scene("res://scenes/maps/room_kost.tscn")

func _on_btn_battle_pressed() -> void:
	_transition_to_scene("res://scenes/minigames/battle_screen.tscn")

func _on_btn_guide_pressed() -> void:
	modal_overlay.visible = true
	modal_guide.visible = true
	modal_settings.visible = false

func _on_btn_settings_pressed() -> void:
	modal_overlay.visible = true
	modal_settings.visible = true
	modal_guide.visible = false
	check_fullscreen.button_pressed = (DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_btn_close_modal_pressed() -> void:
	modal_overlay.visible = false
	modal_settings.visible = false
	modal_guide.visible = false
	btn_start.grab_focus()

func _on_check_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_btn_exit_pressed() -> void:
	get_tree().quit()
