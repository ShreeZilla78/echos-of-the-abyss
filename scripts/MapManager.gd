# MapManager.gd
extends Node

# This script persists between ALL scenes

# Track which zone the player is in
var current_zone: int = 0
var total_zones: int = 5

# Player stats that carry between zones
var player_health: int = 50
var player_max_health: int = 50
var player_deck: Array = []



# Enemy info for battles
var current_enemy: String = "basic"

# Zone scene paths in order
var zone_scenes = [
	"res://scenes/SurfaceMap.tscn",  # Zone 0 - Surface
	"res://scenes/Shallows.tscn", # Zone 1 - Shallows
	"res://scenes/Midzone.tscn", # Zone 2 - Midzone
	"res://scenes/AbyssThreshold.tscn", # Zone 3 - Abyss Threshold
	"res://scenes/FinalDark.tscn" # Zone 4 - Final Dark/End Zone
]

func go_to_next_zone():
	if current_zone < total_zones - 1:
		current_zone += 1
		get_tree().change_scene_to_file(zone_scenes[current_zone])
	else:
		# All zones complete — go to final boss
		get_tree().change_scene_to_file("res://scenes/FinalBoss.tscn")

func go_to_battle():
	# Save player health before battle
	get_tree().change_scene_to_file("res://Battle.tscn")

func get_atmosphere_color() -> Color:
	# Returns a color based on current depth
	# Gets darker and more blue the deeper you go
	match current_zone:
		0: return Color(0.4, 0.6, 0.9)   # Bright blue
		1: return Color(0.2, 0.4, 0.7)   # Medium blue
		2: return Color(0.1, 0.2, 0.5)   # Dark blue
		3: return Color(0.05, 0.05, 0.2) # Almost black
		4: return Color(0.0, 0.0, 0.0)   # Pure black
		_: return Color(0.4, 0.6, 0.9)
		
func reset_game():
	current_zone = 0
	player_health = player_max_health
	player_deck.clear()
	get_tree().change_scene_to_file(zone_scenes[current_zone])

func return_to_map():
	# After battle, return to current zone
	get_tree().change_scene_to_file(zone_scenes[current_zone])
