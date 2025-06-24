@tool
extends Area2D

# You can tweak this force as needed
@export var bounce_force = 500  # Upward force
@export var sprite : Sprite2D
@export var line_color: Color = Color.RED
@export var line_length: float = 50

func _ready():
	if Engine.is_editor_hint():
		queue_redraw()  # Triggers _draw()

func _draw():
	if not Engine.is_editor_hint():
		return
	var direction = Vector2.UP
	draw_line(Vector2.ZERO, direction * line_length, line_color, 1.0)
	print("draw line")

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController and body.has_method("apply_bounce"):
		var bounce_direction = Vector2.UP.rotated(global_rotation)
		body.apply_bounce(bounce_direction * bounce_force)
