extends CSGBox3D

@export var rotation_direction : Vector3 = Vector3.FORWARD
@export var rotation_amount : float = 0.5
@export var movement_direction : Vector3 = Vector3.ZERO
@export_range(0,20) var speed : float = 0
@export var wait_time : float = 0

func _ready():
	if wait_time > 0:
		$Timer.wait_time = wait_time
		$Timer.start()

func _physics_process(delta):
	transform.basis = transform.basis.rotated(rotation_direction, rotation_amount * delta)
	position +=  movement_direction * speed * delta


func _on_timer_timeout():
	movement_direction = movement_direction * -1
	var speed_backup = speed
	speed = 0
	await get_tree().create_timer(0.5).timeout
	$Timer.wait_time = wait_time
	speed = speed_backup
	$Timer.start()

