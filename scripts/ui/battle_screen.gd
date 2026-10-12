extends Control

## Battle Controller Turn-Based khas Citampi Stories
## Giliran Player vs Maling Jemuran lengkap dengan Animasi, Log Teks, HP Bar, & Sound

@export var player_max_hp: int = 40
@export var player_max_mp: int = 20
@export var enemy_max_hp: int = 18

var player_hp: int = 39
var player_mp: int = 20
var enemy_hp: int = 18
var is_player_turn: bool = true

@onready var label_turn: Label = $VBoxCenter/LabelTurn
@onready var label_log: Label = $VBoxCenter/LabelLog
@onready var bar_hp_top: ProgressBar = $TopLeftHUD/VBoxHUD/BarHP
@onready var bar_mp_top: ProgressBar = $TopLeftHUD/VBoxHUD/BarMP
@onready var label_hp_val: Label = $TopLeftHUD/VBoxHUD/BarHP/LabelVal
@onready var label_mp_val: Label = $TopLeftHUD/VBoxHUD/BarMP/LabelVal

@onready var bar_player_field: ProgressBar = $Arena/PlayerNode/BarPlayerHP
@onready var label_player_hp_field: Label = $Arena/PlayerNode/LabelPlayerHPVal
@onready var bar_enemy_field: ProgressBar = $Arena/EnemyNode/BarEnemyHP
@onready var label_enemy_hp_field: Label = $Arena/EnemyNode/LabelEnemyHPVal

@onready var player_sprite: Sprite2D = $Arena/PlayerNode/PlayerSprite
@onready var enemy_sprite: Sprite2D = $Arena/EnemyNode/EnemySprite
@onready var vbox_actions: VBoxContainer = $BottomUI/CenterContainer/VBoxActions

func _ready() -> void:
	update_all_ui()
	set_turn_player()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func update_all_ui() -> void:
	# Top Left Bar
	bar_hp_top.max_value = player_max_hp
	bar_hp_top.value = player_hp
	label_hp_val.text = "%d/%d" % [player_hp, player_max_hp]
	
	bar_mp_top.max_value = player_max_mp
	bar_mp_top.value = player_mp
	label_mp_val.text = "%d/%d" % [player_mp, player_max_mp]
	
	# Field Player
	bar_player_field.max_value = player_max_hp
	bar_player_field.value = player_hp
	label_player_hp_field.text = "%d/%d" % [player_hp, player_max_hp]
	
	# Field Enemy
	bar_enemy_field.max_value = enemy_max_hp
	bar_enemy_field.value = enemy_hp
	label_enemy_hp_field.text = "%d/%d" % [enemy_hp, enemy_max_hp]

func set_turn_player() -> void:
	is_player_turn = true
	label_turn.text = "Giliran You"
	enable_actions(true)

func set_turn_enemy() -> void:
	is_player_turn = false
	label_turn.text = "Giliran Musuh..."
	enable_actions(false)
	get_tree().create_timer(1.2).timeout.connect(_enemy_ai_turn)

func enable_actions(enable: bool) -> void:
	for row in vbox_actions.get_children():
		for btn in row.get_children():
			if btn is BaseButton:
				btn.disabled = not enable

# --- PLAYER ACTIONS ---

func _on_btn_serang_pressed() -> void:
	if not is_player_turn: return
	enable_actions(false)
	
	var dmg: int = randi_range(6, 9)
	enemy_hp = max(0, enemy_hp - dmg)
	label_log.text = "You menyerang Maling Jemuran (%d)." % dmg
	
	# Animasi maju pukul
	var tw = create_tween()
	tw.tween_property(player_sprite, "position:x", 30.0, 0.15)
	tw.tween_property(player_sprite, "position:x", 0.0, 0.15)
	
	# Animasi musuh berkedip merah / kena pukul
	tw.tween_callback(func():
		var tw_e = create_tween()
		tw_e.tween_property(enemy_sprite, "modulate", Color(1, 0.2, 0.2, 1), 0.1)
		tw_e.tween_property(enemy_sprite, "modulate", Color.WHITE, 0.1)
		update_all_ui()
		check_battle_outcome()
	)

func _on_btn_isi_mp_pressed() -> void:
	if not is_player_turn: return
	enable_actions(false)
	player_mp = min(player_max_mp, player_mp + 10)
	label_log.text = "You berdoa dan memulihkan 10 MP!"
	update_all_ui()
	get_tree().create_timer(1.0).timeout.connect(set_turn_enemy)

func _on_btn_bakpia_pressed() -> void:
	if not is_player_turn: return
	enable_actions(false)
	var heal: int = 15
	player_hp = min(player_max_hp, player_hp + heal)
	label_log.text = "You makan Bakpia lezat (+%d HP)!" % heal
	update_all_ui()
	get_tree().create_timer(1.0).timeout.connect(set_turn_enemy)

func _on_btn_geprek_pressed() -> void:
	if not is_player_turn: return
	if player_mp < 8:
		label_log.text = "MP tidak cukup untuk jurus Ayam Geprek!"
		return
	enable_actions(false)
	player_mp -= 8
	var dmg: int = randi_range(12, 16)
	enemy_hp = max(0, enemy_hp - dmg)
	label_log.text = "You melempar Ayam Geprek Pedas Level 10 (%d DMG)!" % dmg
	update_all_ui()
	check_battle_outcome()

func _on_btn_mercon_pressed() -> void:
	if not is_player_turn: return
	if player_mp < 12:
		label_log.text = "MP tidak cukup untuk Oseng Mercon!"
		return
	enable_actions(false)
	player_mp -= 12
	var dmg: int = 18
	enemy_hp = max(0, enemy_hp - dmg)
	label_log.text = "Jurus Oseng Mercon Meledak (%d DMG)!" % dmg
	update_all_ui()
	check_battle_outcome()

func _on_btn_mundur_pressed() -> void:
	label_log.text = "You kabur naik motor bebek hijau!"
	enable_actions(false)
	get_tree().create_timer(1.0).timeout.connect(func():
		get_tree().change_scene_to_file("res://scenes/maps/room_kost.tscn")
	)

func _on_btn_lewati_pressed() -> void:
	label_log.text = "You melempar sandal jepit tapi meleset!"
	enable_actions(false)
	get_tree().create_timer(1.0).timeout.connect(set_turn_enemy)

# --- ENEMY TURN ---

func _enemy_ai_turn() -> void:
	if enemy_hp <= 0: return
	
	var dmg: int = randi_range(3, 7)
	player_hp = max(0, player_hp - dmg)
	label_log.text = "Maling Jemuran menyabet celana jeans (%d DMG)!" % dmg
	
	# Animasi musuh maju
	var tw = create_tween()
	tw.tween_property(enemy_sprite, "position:x", -30.0, 0.15)
	tw.tween_property(enemy_sprite, "position:x", 0.0, 0.15)
	
	tw.tween_callback(func():
		var tw_p = create_tween()
		tw_p.tween_property(player_sprite, "modulate", Color(1, 0.2, 0.2, 1), 0.1)
		tw_p.tween_property(player_sprite, "modulate", Color.WHITE, 0.1)
		update_all_ui()
		if player_hp <= 0:
			label_log.text = "You pingsan! Maling berhasil kabur."
			enable_actions(false)
		else:
			get_tree().create_timer(0.8).timeout.connect(set_turn_player)
	)

func check_battle_outcome() -> void:
	if enemy_hp <= 0:
		label_log.text = "Maling Jemuran K.O.! Jemuran tetangga terselamatkan (+Rp 50.000)!"
		GameState.add_money(50000)
		enable_actions(false)
		get_tree().create_timer(2.0).timeout.connect(func():
			get_tree().change_scene_to_file("res://scenes/maps/room_kost.tscn")
		)
	else:
		get_tree().create_timer(0.8).timeout.connect(set_turn_enemy)
