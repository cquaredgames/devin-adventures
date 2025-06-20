extends Node2D

func _ready() -> void:
	GameManager.reset_gameplay_components()
	GameManager.load_level(GameManager.starting_level)
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Assets/Scenes/UI/main_menu.tscn")
