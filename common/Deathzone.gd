extends Area3D

class_name Deathzone

signal player_died

func _on_body_entered(body):
	if body is Player:
		player_died.emit()
	
