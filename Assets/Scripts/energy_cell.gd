extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		# pick up energy cell
		GameManager.add_energy_cell()
		queue_free()
