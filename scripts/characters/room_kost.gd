extends Node2D

## Scene Kamar Kos Joko Lengkap
## Berisi Kasur, Kipas Angin, Lemari Plastik, Dispenser Galon, Kardus & Ransel, serta Pintu Keluar.

@onready var player: Player = $YSortNodes/Player
@onready var dialogue_box: DialogueBoxController = $DialogueBox
@onready var hud: CanvasLayer = $HUD

func _ready() -> void:
	if not GameState.get_flag("has_talked_to_bu_wati"):
		call_deferred("_trigger_intro_dialogue")

func _trigger_intro_dialogue() -> void:
	var intro: Array[Dictionary] = [
		{
			"speaker": "Joko",
			"text": "Akhirnya sampai juga di kosan... Kamar petak tiga kali tiga meter.",
			"portrait": "res://assets/sprites/portraits/joko_normal.png"
		},
		{
			"speaker": "Joko",
			"text": "Uang di dompet tinggal Rp 50.000... Aku harus keluar temui Bu Wati dan cari kerja serabutan.",
			"portrait": "res://assets/sprites/portraits/joko_normal.png"
		}
	]
	dialogue_box.start_dialogue(intro)

func _on_bed_interacted() -> void:
	if GameState.get_current_phase_name() == "Malam":
		var bed_dlg: Array[Dictionary] = [
			{
				"speaker": "Joko",
				"text": "Badan remuk redam... Waktunya tidur biar besok ada tenaga cari nafkah.",
				"portrait": "res://assets/sprites/portraits/joko_normal.png"
			}
		]
		dialogue_box.start_dialogue(bed_dlg)
		dialogue_box.dialogue_finished.connect(func(): GameState.sleep_and_advance_day(), CONNECT_ONE_SHOT)
	else:
		var noon_dlg: Array[Dictionary] = [
			{
				"speaker": "Joko",
				"text": "Masih " + GameState.get_current_phase_name() + ", belum waktunya tidur! Mending keluar cari info kerja.",
				"portrait": "res://assets/sprites/portraits/joko_normal.png"
			}
		]
		dialogue_box.start_dialogue(noon_dlg)

func _on_door_interacted() -> void:
	var door_dlg: Array[Dictionary] = [
		{
			"speaker": "Joko",
			"text": "Buka pintu... Keluar menuju gang kosan.",
			"portrait": "res://assets/sprites/portraits/joko_normal.png"
		}
	]
	dialogue_box.start_dialogue(door_dlg)
	dialogue_box.dialogue_finished.connect(func(): get_tree().change_scene_to_file("res://scenes/maps/street_gang.tscn"), CONNECT_ONE_SHOT)

func _on_fan_interacted() -> void:
	dialogue_box.start_dialogue([
		{
			"speaker": "Joko",
			"text": "Kipas angin kosan nomor tiga... Suaranya berisik kayak helikopter, tapi lumayan ngusir gerah.",
			"portrait": "res://assets/sprites/portraits/joko_normal.png"
		}
	])
	GameState.modify_stress(-5)

func _on_dispenser_interacted() -> void:
	dialogue_box.start_dialogue([
		{
			"speaker": "Joko",
			"text": "Teguk air putih segelas... Segar! Tenggorokan gak kering lagi.",
			"portrait": "res://assets/sprites/portraits/joko_normal.png"
		}
	])
	GameState.modify_hunger(5)

func _on_wardrobe_interacted() -> void:
	dialogue_box.start_dialogue([
		{
			"speaker": "Joko",
			"text": "Lemari plastik isi baju ganti dari kampung sama amplop titipan Ibu...",
			"portrait": "res://assets/sprites/portraits/joko_normal.png"
		}
	])
