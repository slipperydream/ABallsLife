extends VBoxContainer

signal time_expired
signal time_running_out

@onready var time = $Time
var max_stage_time : int = 400
var current_time : int = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	set_stage_time(max_stage_time)
		
func _on_timer_timeout():
	current_time -= 1
	update_time()

	if current_time <= 0:
		emit_signal("time_expired")
	$Timer.start()

func set_stage_time(value):
	max_stage_time = value
	current_time = max_stage_time
	update_time()
	$Timer.start()
	
func get_remaining_time():
	return current_time

func update_time():
	time.text = str(current_time)
	if current_time < 100:
		time.add_theme_color_override("font_color", Color.RED)
		time_running_out.emit()
		
