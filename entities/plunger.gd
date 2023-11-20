extends CSGCombiner3D

@export var force : float = 75
@export var start_pos : Vector3 
@export var end_pos : Vector3
@export var wait_time : int = 2

func _on_area_3d_body_entered(body):
	if body is BowlingBall or Player:
		body.linear_velocity += Vector3.FORWARD * force
		body.apply_central_impulse(body.linear_velocity * 0.1)

func _on_timer_timeout():
	var tween = create_tween()
	tween.tween_property(self, "position", end_pos, 1)
	await get_tree().create_timer(1).timeout
	tween = create_tween()
	tween.tween_property(self, "position", start_pos, 1)
	

func start():
	$Timer.wait_time = wait_time
	$Timer.start()
