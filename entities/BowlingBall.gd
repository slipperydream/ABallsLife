extends RigidBody3D

class_name BowlingBall

@export var ball_color : Color
@onready var ball = $CollisionShape3D/CSGSphere3D

func _ready():
	var mat = StandardMaterial3D.new()
	mat.albedo_color = ball_color
	ball.material = mat
