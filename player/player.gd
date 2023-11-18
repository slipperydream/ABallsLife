extends RigidBody3D

@export var rolling_force = 40
@onready var camera_rig = $CameraRig

func _ready():
	camera_rig.top_level = true


func _physics_process(delta):
	# move the camera rig along with the ball as it moves forward
	var old_camera_pos = camera_rig.global_transform.origin
	var player_pos = global_transform.origin
	var new_camera_pos = lerp(old_camera_pos, player_pos, 0.1)
	camera_rig.global_transform.origin = new_camera_pos
	
	angular_velocity.x += rolling_force * Input.get_axis("move_forward", "move_backwards") * delta
	angular_velocity.z += rolling_force * Input.get_axis("move_right", "move_left") * delta
	
