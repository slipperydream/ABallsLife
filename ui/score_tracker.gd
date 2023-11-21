extends VBoxContainer

func _on_main_score_changed(value):
	$Score.text = str(value)
