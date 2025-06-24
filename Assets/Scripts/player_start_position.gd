@tool
extends Node2D

@export var color: Color = Color(1, 1, 0, 1) # Yellow

func _ready():
	if Engine.is_editor_hint():
		queue_redraw()

func _draw():
	if not Engine.is_editor_hint():
		return
	draw_circle(Vector2.ZERO, 8, color) 
