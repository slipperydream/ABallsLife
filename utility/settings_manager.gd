extends Node

signal settings_reverted

const SETTINGS_FILE_PATH = "res://settings.cfg"

var config = ConfigFile.new()

var settings = {
	"audio" : {
		"master_muted": false,
		"master_volume": -6.0,
		"music_muted": false,
		"music_volume": -6.0,
		"sfx_muted": false,
		"sfx_volume": -6.0,
	},
	"gameplay": {
		"skip_intro": false,
		"skip_cutscenes": false,
	},
	"input": {
		"main_fire": KEY_SPACE
	},
	"visual": {
		"show_hitboxes": true,
		"display_mode": "FULLSCREEN",
		"resolution": "1920x1080",
		"aspect_ration": "DISPLAY",
		"v_sync": true,
	}
}

func _ready():
	#revert_settings()
	load_settings()
	print(settings)
	
func save_settings():
	for section in settings.keys():
		for key in settings[section]:
			config.set_value(section, key, settings[section][key])
			
	config.save(SETTINGS_FILE_PATH)
	emit_signal("settings_reverted")
	
func load_settings():
	var error = config.load(SETTINGS_FILE_PATH)
	if error != OK:
		print("Error loading settings file. %s" % error)
		return []
		
	for section in settings.keys():
		for key in settings[section].keys():
			settings[section][key] = config.get_value(section, key, null)

func get_settings():
	return settings
	
func get_audio_bus_muted(bus):
	var audio_bus = "%s_muted" % bus.to_lower()
	return settings["audio"][audio_bus]

func set_audio_bus_muted(bus, value):
	var key = "%s_muted" % bus.to_lower()
	settings["audio"][key] = value
	save_settings()
		
func get_audio_bus_volume(bus):
	var audio_bus = "%s_volume" % bus.to_lower()
	return settings["audio"][audio_bus]
	
func set_audio_bus_volume(bus, value):
	var key = "%s_volume" % bus.to_lower()
	settings["audio"][key] = value
	save_settings()
	
	
