extends Level

@export var zoomed_camera_pos : Vector3 = Vector3(0, 5, 10)
# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	$Plunger.start()

func _on_deathzone_player_died():
	super._on_deathzone_player_died()
	$Plunger.start()


func _on_camera_change_body_entered(body):
	player.set_camera_pos(zoomed_camera_pos)
