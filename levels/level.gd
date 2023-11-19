extends Node3D

class_name Level
signal beat_last_level


@onready var player = get_tree().get_first_node_in_group("Player")
@export var player_start : Vector3 = Vector3.ZERO
@export_file("*.tscn") var next_level

func _ready():
	player.reset(player_start)
	
func _on_deathzone_player_died():
	player.reset(player_start)


func _on_goal_goal_reached():
	await get_tree().create_timer(2).timeout
	if next_level:
		get_tree().change_scene_to_file(next_level)
	else:
		beat_last_level.emit()

