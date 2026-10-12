extends CharacterBody2D
class_name Player

## Skrip pengontrol karakter utama Joko.
## Mendukung pergerakan 4 arah top-down, interaksi objek, dan manajemen stamina.

@export var move_speed: float = 120.0
@export var sprint_speed: float = 170.0

@onready var interaction_ray: RayCast2D = $InteractionRay
@onready var sprite: Sprite2D = $Sprite2D

var facing_direction: Vector2 = Vector2.DOWN
var is_can_move: bool = true

func _physics_process(_delta: float) -> void:
	if not is_can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	handle_movement()
	handle_interaction()

func handle_movement() -> void:
	var input_vector: Vector2 = Vector2.ZERO
	input_vector.x = Input.get_action_raw_strength("ui_right") - Input.get_action_raw_strength("ui_left")
	input_vector.y = Input.get_action_raw_strength("ui_down") - Input.get_action_raw_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		facing_direction = input_vector
		update_interaction_ray_direction()
		
		# Cek apakah lari (Shift)
		var current_speed: float = move_speed
		if Input.is_key_pressed(KEY_SHIFT) and GameState.energy > 15:
			current_speed = sprint_speed
			
		velocity = input_vector * current_speed
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()

func update_interaction_ray_direction() -> void:
	# Prioritaskan arah kardinal (4 arah utama) untuk raycast interaksi
	if abs(facing_direction.x) > abs(facing_direction.y):
		interaction_ray.target_position = Vector2(sign(facing_direction.x) * 24.0, 0.0)
	else:
		interaction_ray.target_position = Vector2(0.0, sign(facing_direction.y) * 24.0)

func handle_interaction() -> void:
	if Input.is_action_just_pressed("ui_accept"): # Tombol Enter / Space
		if interaction_ray.is_colliding():
			var collider = interaction_ray.get_collider()
			if collider and collider.has_method("interact"):
				collider.interact()
