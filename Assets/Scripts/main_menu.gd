extends Control

@export var gameplay_scene : PackedScene

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		change_to_gameplay_scene()
		return
		
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	

func _on_play_game_button_pressed() -> void:
	change_to_gameplay_scene()
	
func change_to_gameplay_scene():
	get_tree().change_scene_to_packed(gameplay_scene)
