extends CSGBox3D

class_name Goal
	
@export var direction : Vector3 = Vector3.ZERO
@export var speed : float = 0
@export var wait_time : float = 0
signal goal_reached

func _ready():
	if wait_time > 0:
		$Timer.wait_time = wait_time
		$Timer.start()

func _physics_process(delta):
	position += direction * speed * delta

func _on_area_3d_body_entered(body):
	if body is Player:
		goal_reached.emit()

func _on_timer_timeout():
	var speed_backup = speed
	direction = direction * -1
	speed = 0
	await get_tree().create_timer(0.5).timeout
	$Timer.wait_time = wait_time
	speed = speed_backup
	$Timer.start()

