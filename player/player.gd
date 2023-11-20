extends RigidBody3D

class_name Player

@export var rolling_force = 40
@export var jump_impulse = 1000
@export var camera_pos : Vector3 = Vector3(0, 2.85, 3.5)

@onready var camera_rig = $CameraRig
@onready var floor_check = $FloorCheck

func _ready():
	camera_rig.top_level = true
	floor_check.top_level = true
	$CameraRig/Camera3D.position = camera_pos


func _physics_process(delta):
	# move the camera rig along with the ball as it moves forward
	var old_camera_pos = camera_rig.global_transform.origin
	var player_pos = global_transform.origin
	var new_camera_pos = lerp(old_camera_pos, player_pos, 0.1)
	camera_rig.global_transform.origin = new_camera_pos

	
	floor_check.global_transform.origin = global_transform.origin
	
	angular_velocity.x += rolling_force * Input.get_axis("move_forward", "move_backwards") * delta
	angular_velocity.z += rolling_force * Input.get_axis("move_right", "move_left") * delta
	
	var is_on_floor = floor_check.is_colliding()
	if Input.is_action_just_pressed("jump") and is_on_floor:
		apply_central_impulse(Vector3.UP * jump_impulse)
	
func reset(pos):
	angular_velocity = Vector3.ZERO
	linear_velocity = Vector3.ZERO
	global_position = pos
	
func set_camera_pos(pos : Vector3):
	var tween = create_tween()
	tween.tween_property($CameraRig/Camera3D, "position", pos, 1)
