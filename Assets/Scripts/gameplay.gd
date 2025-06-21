extends Node2D

@export var starting_level = 1

func _ready() -> void:
	GameManager.STARTING_LEVEL = starting_level
	GameManager.reset_gameplay_components()
	GameManager.load_level()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Assets/Scenes/UI/main_menu.tscn")
