extends Node3D

class_name main
signal score_changed
signal game_over

var current_level  
@export_file("*.tscn") var first_level

@export var player_scene : PackedScene 
@onready var title_screen = $TitleScreen
@onready var time = $Time
@onready var lifecounter = $LifeCounter
@onready var score_tracker = $ScoreTracker

@export var points_per_sec : int = 5
@export var points_per_level : int = 10000
var score : int = 0
@export var starting_lives : int = 3 
var lives : int

func _ready():
	title_screen.show()
	show_ui(false)
	
func new_game():
	score = 0
	lives = starting_lives
	var player = player_scene.instantiate()
	add_child(player)
	load_level(first_level)
	lifecounter.update_lives(lives)

func load_level(level):
	var new_level = load(level)
	current_level = new_level.instantiate()
	add_child(current_level)
	time.set_stage_time(current_level.stage_time_seconds)
	show_ui(true)

func _on_finished_level():
	var time_remaining = time.get_remaining_time()
	update_score(time_remaining * points_per_sec)
	update_score(points_per_level)
	if current_level.next_level:
		var new_level = current_level.next_level
		current_level.queue_free()
		load_level(new_level)
	else:
		print("you beat the game!")
		
func _on_title_screen_new_game():
	new_game()
	title_screen.hide()
	
func _on_player_death():
	lives -= 1
	lifecounter.update_lives(lives)
	if lives <= 0:
		game_over.emit()
	
func show_ui(value):
	time.visible = value
	lifecounter.visible = value
	score_tracker.visible = value
	
func update_score(value):
	score += value
	emit_signal("score_changed", score)

func _on_game_over():
	$GameOverTimer.wait_time = 3
	$GameOverTimer.start()
	
func clear_game():
	current_level = null
	score = 0

func _on_game_over_timer_timeout():
	show_ui(false)
	clear_game()
	title_screen.show()
