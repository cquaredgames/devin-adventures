extends CharacterBody2D

class_name PlayerController

@export var speed = 15.0
@export var jump_power = 30.0
@export var camera : Camera2D

var jump_multiplier = -10.0
var speed_multiplier = 10.0
var direction = 0

func _input(event: InputEvent) -> void:
	# Handle jump.
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
		
	# Handle jump down
	if event.is_action_pressed("jump_down"):
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta	
		
	if Input.is_key_pressed(KEY_0):
		position.y = -500

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	move_and_slide()


func teleport_to_location(new_location):
	camera.position_smoothing_enabled = false
	position = new_location
	await get_tree().physics_frame
	camera.position_smoothing_enabled = true
