extends CharacterBody2D

class_name PlayerController

@export var speed = 15.0
@export var jump_power = 30.0
@export var camera : Camera2D

var bounce_timer := 0.0
@export var bounce_duration := 0.5

var jump_multiplier = -10.0
var speed_multiplier = 10.0
var direction = 0

@onready var ray_left = $RayCastLeft
@onready var ray_right = $RayCastRight
@export var wall_jump_force = Vector2(1000, -100)
var wall_jump_timer := 0.0

func _input(event: InputEvent) -> void:
	# Handle jump.
	if event.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_power * jump_multiplier
		elif is_touching_wall():
			direction = -get_wall_direction()
			velocity.x = direction * wall_jump_force.x
			velocity.y = wall_jump_force.y
			wall_jump_timer = 0.5
		
	# Handle jump down
	if event.is_action_pressed("jump_down"):
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)
	
func _physics_process(delta: float) -> void:
	if bounce_timer > 0:
		bounce_timer -= delta
		move_and_slide()
		return
		
	if wall_jump_timer > 0:
		wall_jump_timer -= delta
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta	
		
	if Input.is_key_pressed(KEY_0):
		position.y = -500


	if wall_jump_timer <= 0:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		direction = Input.get_axis("move_left", "move_right")
		
		if direction:
			velocity.x = direction * speed * speed_multiplier
		else:
			velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	move_and_slide()

func apply_bounce(force: Vector2):
	velocity = force
	bounce_timer = bounce_duration

func teleport_to_location(new_location):
	camera.position_smoothing_enabled = false
	position = new_location
	await get_tree().physics_frame
	camera.position_smoothing_enabled = true
	
func is_touching_wall() -> bool:
	return ray_left.is_colliding() || ray_right.is_colliding()
	
func get_wall_direction() -> int:
	if ray_left.is_colliding():
		return -1
	elif ray_right.is_colliding():
		return 1
	return 0
