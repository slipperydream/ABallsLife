extends CSGBox3D

class_name ScoringArea

signal pins_recorded
signal reset_player

var pin_count : int = 0

func _ready():
	pin_count = 0


func _on_area_3d_body_entered(body):
	$Timer.start()
	if body is Player:
		reset_player.emit()
	if body is BowlingPin:
		pin_count += 1
		body.scored = true


func _on_timer_timeout():
	emit_signal("pins_recorded", pin_count)
	print(pin_count)
