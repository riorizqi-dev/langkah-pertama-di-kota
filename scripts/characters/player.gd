extends CharacterBody2D
class_name Player

## Skrip pengontrol karakter utama Joko (Langkah 1: Input & Gerak).
## Menggunakan Input.get_vector() dengan dukungan WASD, Panah, dan Gamepad.

@export var move_speed: float = 90.0
@export var sprint_speed: float = 145.0

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
	# Input.get_vector otomatis menormalisasi gerak diagonal (panjang vektor maks 1.0)
	var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_vector != Vector2.ZERO:
		facing_direction = input_vector
		update_interaction_ray_direction()
		
		var current_speed: float = move_speed
		if Input.is_action_pressed("run") and GameState.energy > 15:
			current_speed = sprint_speed
			
		velocity = input_vector * current_speed
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()

func update_interaction_ray_direction() -> void:
	if abs(facing_direction.x) > abs(facing_direction.y):
		interaction_ray.target_position = Vector2(sign(facing_direction.x) * 20.0, 0.0)
	else:
		interaction_ray.target_position = Vector2(0.0, sign(facing_direction.y) * 20.0)

func handle_interaction() -> void:
	if Input.is_action_just_pressed("interact"):
		if interaction_ray.is_colliding():
			var collider = interaction_ray.get_collider()
			if collider and collider.has_method("interact"):
				collider.interact()
