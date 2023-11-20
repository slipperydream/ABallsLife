extends Level

class_name BowlingAlley

const frames = 10
var current_frame : int = 1
var bowling_attempts : int = 0
var bowling_attempts_per_frame : int = 2

func _ready():
	super._ready()
	for child in get_children():
		if child is BowlingPin:
			child.scored = false
	current_frame = 1

func reset_frame():
	for child in get_children():
		if child is BowlingPin:
			child.scored = false
			child.reset()
	player.reset(player_start)
			
func reset_pins():
	for child in get_children():
		if child is BowlingPin:
			if child.scored == false:
				child.reset()


func _on_backstop_pins_recorded(_value):
	reset_pins()

func _on_backstop_reset_player():
	player.reset(player_start)
	bowling_attempts += 1
	check_for_frame_over()
	
func check_for_frame_over():
	if current_frame < 10:
		if bowling_attempts >= bowling_attempts_per_frame:
			reset_frame()
			print("new_frame")
	finished_level.emit()
		

func _on_deathzone_player_died():
	super._on_deathzone_player_died()
	bowling_attempts += 1
	check_for_frame_over()
