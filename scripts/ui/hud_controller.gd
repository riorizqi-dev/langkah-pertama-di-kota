extends CanvasLayer

## Controller HUD untuk memantau status energi, lapar, stres, uang, dan waktu.

@onready var label_money: Label = $MarginContainer/VBoxContainer/TopRow/LabelMoney
@onready var label_time: Label = $MarginContainer/VBoxContainer/TopRow/LabelTime
@onready var bar_energy: ProgressBar = $MarginContainer/VBoxContainer/StatusBars/BarEnergy
@onready var bar_hunger: ProgressBar = $MarginContainer/VBoxContainer/StatusBars/BarHunger
@onready var bar_stress: ProgressBar = $MarginContainer/VBoxContainer/StatusBars/BarStress

func _ready() -> void:
	# Hubungkan sinyal dari GameState Autoload
	GameState.stats_changed.connect(_on_stats_changed)
	GameState.time_changed.connect(_on_time_changed)
	
	# Inisialisasi tampilan awal
	_update_ui(GameState.energy, GameState.hunger, GameState.stress, GameState.money)
	_on_time_changed(GameState.current_day, GameState.get_current_phase_name())

func _on_stats_changed(energy: int, hunger: int, stress: int, money: int) -> void:
	_update_ui(energy, hunger, stress, money)

func _on_time_changed(day: int, time_phase: String) -> void:
	label_time.text = "Hari ke-%d [%s]" % [day, time_phase]

func _update_ui(energy: int, hunger: int, stress: int, money: int) -> void:
	label_money.text = "Rp " + str(money)
	bar_energy.value = energy
	bar_hunger.value = hunger
	bar_stress.value = stress

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

