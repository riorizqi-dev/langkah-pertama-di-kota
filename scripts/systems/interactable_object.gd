extends Area2D
class_name InteractableObject

## Komponen dasar untuk objek atau NPC yang bisa diajak interaksi.
## Menampilkan prompt "[E] ..." saat Player berada di dekat objek.

signal on_interacted

@export var prompt_message: String = "Periksa"
@export_multiline var dialogue_text: String = "Tidak ada hal menarik di sini."

@onready var prompt_label: Label = get_node_or_null("PromptLabel")

var is_player_in_range: bool = false

func _ready() -> void:
	if prompt_label:
		prompt_label.text = "[E] " + prompt_message
		prompt_label.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player_in_range = true
		if body.has_method("register_nearby_interactable"):
			body.register_nearby_interactable(self)
		if prompt_label:
			prompt_label.text = "[E] " + prompt_message
			prompt_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player_in_range = false
		if body.has_method("unregister_nearby_interactable"):
			body.unregister_nearby_interactable(self)
		if prompt_label:
			prompt_label.visible = false

func interact() -> void:
	print("[Interactable] Berinteraksi dengan: ", name)
	if prompt_label:
		prompt_label.visible = false
	emit_signal("on_interacted")
