extends Area3D

class_name Trap
@export var force : float = 75
@export var image : Texture2D

func _ready():
	$Sprite3D.texture = image
	
func _on_body_entered(body):
	if body is BowlingBall or Player:
		body.linear_velocity += Vector3.FORWARD * force
		body.apply_central_impulse(body.linear_velocity * 0.1)
