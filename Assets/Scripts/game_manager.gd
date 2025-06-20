extends Node

var starting_level = 1
var current_level = 1
var level_path = "res://Assets/Scenes/Levels/"

var energy_cells = 0
var level_container : Node2D
var player : PlayerController

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	level_container = get_tree().get_first_node_in_group("level_container")
	load_level(starting_level)

func next_level():
	current_level += 1
	load_level(current_level)
	
func load_level(level_number):
	var level_full_path = level_path + "/level_" + str(level_number) + ".tscn"
	var scene = load(level_full_path) as PackedScene
	
	# Test if valid scene
	if !scene:
		return
	
	# removing the previous screen
	for child in level_container.get_children():
		child.queue_free()
		await child.tree_exited
		
	# setting up new scene
	var instance = scene.instantiate()
	level_container.add_child(instance)
	
	reset_energy_cells()
	
	var player_start_position = get_tree().get_first_node_in_group("player_start_position") as Node2D
	player.teleport_to_location(player_start_position.position)
	
func add_energy_cell():
	energy_cells += 1
	if energy_cells >= 4:
		# open portal
		var portal = get_tree().get_first_node_in_group("level_exits") as LevelExit
		portal.open()
		
		pass
	
func reset_energy_cells():
	energy_cells = 0
	
