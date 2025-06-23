extends Area2D

# You can tweak this force as needed
@export var bounce_force = 500  # Upward force
@export var sprite : Sprite2D


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController and body.has_method("apply_bounce"):
		var bounce_direction = Vector2.UP.rotated(global_rotation)
		body.velocity.x = -800
		body.velocity.y = -300
		body.apply_bounce(bounce_direction * bounce_force)
