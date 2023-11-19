extends Node3D

class_name main

var current_level  
@export_file("*.tscn") var first_level

func _ready():
	new_game()
	
func new_game():
	load_level(first_level)

func load_level(level):
	var new_level = load(level)
	current_level = new_level.instantiate()
	add_child(current_level)

func _on_finished_level():
	if current_level.next_level:
		var new_level = current_level.next_level
		current_level.queue_free()
		load_level(new_level)
	else:
		print("you beat the game!")
		
