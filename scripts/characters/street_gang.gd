extends Node2D

## Scene Area Luar Gang Kosan & Warkop Cak Man
## Tempat Joko bertemu Bu Wati (Ibu Kos) dan Cak Man (Warkop)

@onready var dialogue_box: DialogueBoxController = $DialogueBox
@onready var hud: CanvasLayer = $HUD

func _ready() -> void:
	pass

func _on_bu_wati_interacted() -> void:
	if not GameState.get_flag("has_talked_to_bu_wati"):
		dialogue_box.start_dialogue([
			{
				"speaker": "Bu Wati",
				"text": "Kamu yang namanya Joko anak perantau baru itu kan? Kamar nomor 3?",
				"portrait": "res://assets/sprites/portraits/bu_wati_galak.png"
			},
			{
				"speaker": "Joko",
				"text": "I-iya, Bu Wati... Salam kenal, Bu.",
				"portrait": "res://assets/sprites/portraits/joko_normal.png"
			},
			{
				"speaker": "Bu Wati",
				"text": "Ingat ya! Uang sewa Rp 350.000 jangan sampai telat. Kalau mau cari makan atau info kerja serabutan, coba ke Warkop Cak Man di ujung gang sana.",
				"portrait": "res://assets/sprites/portraits/bu_wati_galak.png"
			}
		])
		GameState.set_flag("has_talked_to_bu_wati", true)
	else:
		dialogue_box.start_dialogue([
			{
				"speaker": "Bu Wati",
				"text": "Ngapain masih bengong? Cepat cari kerja sana di warkop atau pasar, jangan malas di kota orang!",
				"portrait": "res://assets/sprites/portraits/bu_wati_galak.png"
			}
		])

func _on_warkop_interacted() -> void:
	dialogue_box.start_dialogue([
		{
			"speaker": "Cak Man",
			"text": "Monggo, Mas! Mau ngopi tubruk, gorengan anget, apa cari info lowongan kerja?",
			"portrait": "res://assets/sprites/portraits/joko_normal.png"
		},
		{
			"speaker": "Joko",
			"text": "Cak Man, ada kerjaan serabutan gak ya buat anak baru kayak saya?",
			"portrait": "res://assets/sprites/portraits/joko_normal.png"
		},
		{
			"speaker": "Cak Man",
			"text": "Pas banget! Di pasar depan lagi butuh orang buat angkut kardus sembako. Upahnya Rp 25.000 lumayan buat nambah uang sewa!",
			"portrait": "res://assets/sprites/portraits/joko_normal.png"
		}
	])
	dialogue_box.dialogue_finished.connect(func():
		GameState.add_money(25000)
		GameState.modify_energy(-20)
		GameState.advance_time_phase()
	, CONNECT_ONE_SHOT)

func _on_door_back_interacted() -> void:
	get_tree().change_scene_to_file("res://scenes/maps/room_kost.tscn")
