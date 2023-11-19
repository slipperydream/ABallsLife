extends RigidBody3D

class_name BowlingPin
@export var starting_point : Vector3 
var scored : bool = false

func reset():
	position = starting_point
	rotation = Vector3.ZERO
