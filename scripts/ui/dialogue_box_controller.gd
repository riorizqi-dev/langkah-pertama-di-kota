extends CanvasLayer
class_name DialogueBoxController

## Controller sistem dialog dengan character portrait dan efek mengetik.

signal dialogue_finished

@onready var panel_container: PanelContainer = $PanelContainer
@onready var label_speaker: Label = $PanelContainer/Margin/HBox/VBox/LabelSpeaker
@onready var label_text: RichTextLabel = $PanelContainer/Margin/HBox/VBox/LabelText
@onready var portrait_rect: TextureRect = $PanelContainer/Margin/HBox/PortraitRect

var dialogue_queue: Array[Dictionary] = []
var is_active: bool = false

func _ready() -> void:
	panel_container.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if is_active and event.is_action_pressed("ui_accept"):
		advance_dialogue()

func start_dialogue(dialogue_list: Array[Dictionary]) -> void:
	dialogue_queue = dialogue_list.duplicate()
	is_active = true
	panel_container.visible = true
	advance_dialogue()

func advance_dialogue() -> void:
	if dialogue_queue.is_empty():
		close_dialogue()
		return
		
	var current: Dictionary = dialogue_queue.pop_front()
	label_speaker.text = current.get("speaker", "")
	label_text.text = current.get("text", "")
	
	# Ganti portrait jika ada path texture
	var portrait_path: String = current.get("portrait", "")
	if portrait_path != "" and ResourceLoader.exists(portrait_path):
		portrait_rect.texture = load(portrait_path)
		portrait_rect.visible = true
	else:
		portrait_rect.visible = false

func close_dialogue() -> void:
	is_active = false
	panel_container.visible = false
	emit_signal("dialogue_finished")
