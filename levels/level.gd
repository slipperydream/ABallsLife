extends Node3D

class_name Level
signal finished_level

@export_file("*.tscn") var next_level
@export var player_start : Vector3 = Vector3.ZERO
@export var player_camera_pos : Vector3 = Vector3(0, 2.85, 3.5)
@export var debug : bool = false

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var main = get_tree().get_first_node_in_group("main")

var finished : bool = false

func _ready():
	if debug:
		pass
		var player_scene = load("res://player/player.tscn")
		player = player_scene.instantiate()
		add_child(player)
	else:
		self.connect("finished_level", main._on_finished_level)
	player.reset(player_start)
	player.set_camera_pos(player_camera_pos)
	
func _on_deathzone_player_died():
	player.reset(player_start)
	player.set_camera_pos(player_camera_pos)


func _on_goal_goal_reached():
	if not finished:
		finished = true
		await get_tree().create_timer(2).timeout
		finished_level.emit()
		

