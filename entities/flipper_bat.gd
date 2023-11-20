extends CharacterBody3D


@export var start_angle : float = 60
@export var end_angle : float = 0
@export var swing_time : float = 2.5
@export var rest_time : float = 1.0

func _ready():
	$Timer.wait_time = swing_time
	$Timer.start()

func swing():
	rotation_degrees.y = end_angle
	await get_tree().create_timer(rest_time).timeout
	rotation_degrees.y = start_angle
	$Timer.start()

func _on_timer_timeout():
	swing()
