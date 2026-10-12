extends Area2D
class_name InteractableObject

## Komponen dasar untuk objek atau NPC yang bisa diajak interaksi.

signal on_interacted

@export var prompt_message: String = "Periksa"
@export_multiline var dialogue_text: String = "Tidak ada hal menarik di sini."

func interact() -> void:
	print("[Interactable] Berinteraksi dengan: ", name)
	emit_signal("on_interacted")
	# Jika ada dialog manager terdaftar, trigger dialog
	if has_node("/root/DialogueManager"):
		get_node("/root/DialogueManager").show_simple_message(dialogue_text)
