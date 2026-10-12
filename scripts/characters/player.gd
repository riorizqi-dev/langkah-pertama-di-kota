extends CharacterBody2D
class_name Player

## Skrip pengontrol karakter utama Joko (Input, Gerak, & Animasi 4 Arah).
## Menggunakan Input.get_vector() dan AnimatedSprite2D (idle/walk 4 arah).

@export var move_speed: float = 130.0
@export var sprint_speed: float = 210.0

@onready var interaction_ray: RayCast2D = $InteractionRay
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

var facing_direction: Vector2 = Vector2.DOWN
var last_dir_name: String = "down"
var is_can_move: bool = true
var nearby_interactables: Array[InteractableObject] = []

func _physics_process(_delta: float) -> void:
	if not is_can_move or _is_dialogue_open():
		velocity = Vector2.ZERO
		_play_animation(false)
		move_and_slide()
		return
		
	handle_movement()
	handle_interaction()

func _is_dialogue_open() -> bool:
	var dlg := get_tree().get_first_node_in_group("dialogue_box")
	if dlg and "is_active" in dlg and dlg.is_active:
		return true
	return false

func handle_movement() -> void:
	var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_vector != Vector2.ZERO:
		facing_direction = input_vector
		_update_direction_name(input_vector)
		update_interaction_ray_direction()
		
		var current_speed: float = move_speed
		var is_running: bool = Input.is_action_pressed("run") and GameState.energy > 15
		if is_running:
			current_speed = sprint_speed
			anim_sprite.speed_scale = 1.5
		else:
			anim_sprite.speed_scale = 1.0
			
		velocity = input_vector * current_speed
		_play_animation(true)
	else:
		velocity = Vector2.ZERO
		anim_sprite.speed_scale = 1.0
		_play_animation(false)
		
	move_and_slide()

func _update_direction_name(vec: Vector2) -> void:
	if abs(vec.x) > abs(vec.y):
		last_dir_name = "right" if vec.x > 0.0 else "left"
	else:
		last_dir_name = "down" if vec.y > 0.0 else "up"

func _play_animation(is_moving: bool) -> void:
	var prefix: String = "walk_" if is_moving else "idle_"
	var target_anim: String = prefix + last_dir_name
	if anim_sprite.animation != target_anim:
		anim_sprite.play(target_anim)

func update_interaction_ray_direction() -> void:
	match last_dir_name:
		"right":
			interaction_ray.target_position = Vector2(26.0, 0.0)
		"left":
			interaction_ray.target_position = Vector2(-26.0, 0.0)
		"down":
			interaction_ray.target_position = Vector2(0.0, 26.0)
		"up":
			interaction_ray.target_position = Vector2(0.0, -26.0)

func register_nearby_interactable(obj: InteractableObject) -> void:
	if not nearby_interactables.has(obj):
		nearby_interactables.append(obj)

func unregister_nearby_interactable(obj: InteractableObject) -> void:
	nearby_interactables.erase(obj)

func handle_interaction() -> void:
	if Input.is_action_just_pressed("interact"):
		if interaction_ray.is_colliding():
			var collider = interaction_ray.get_collider()
			if collider and collider.has_method("interact"):
				get_viewport().set_input_as_handled()
				collider.interact()
				return
		if not nearby_interactables.is_empty():
			var target: InteractableObject = nearby_interactables.back()
			if is_instance_valid(target):
				get_viewport().set_input_as_handled()
				target.interact()
