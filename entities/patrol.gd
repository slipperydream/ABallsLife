extends CSGBox3D

@export var direction : Vector3 = Vector3.LEFT
@export var speed : float = 5
@export var wait_time : float = 3


func _ready():
	$Timer.wait_time = wait_time
	$Timer.start()
	
func _physics_process(delta):
	position += direction * speed * delta


func _on_timer_timeout():
	var speed_backup = speed
	direction = direction * -1
	speed = 0
	await get_tree().create_timer(0.5).timeout
	$Timer.wait_time = wait_time
	speed = speed_backup
	$Timer.start()
