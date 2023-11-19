extends HBoxContainer

var lives : int = 0

func _on_main_player_dead():
	var value = lives - 1
	update_lives(value)

func _on_main_life_earned():
	var value = lives + 1
	update_lives(value)

func _on_main_start_game():
	update_lives(3)

func update_lives(value):
	lives = value
	$Label.text = "x %d" % str(lives)
