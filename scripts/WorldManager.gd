# WorldManager.gd
extends Node

# This script persists between ALL scenes

# Track which zone the player is in
var current_zone: int = 1
var total_zones: int = 5

# Player stats that carry between zones
var player_health: int = 50
var player_max_health: int = 50
var player_deck: Array = []

# Zone scene paths in order
var zone_scenes = [
	"res://Zone1_Surface.tscn",
	"res://Zone2_Shallows.tscn",
	"res://Zone3_Midzone.tscn",
	"res://Zone4_AbyssThreshold.tscn",
	"res://Zone5_FinalDark.tscn"
]

func go_to_next_zone():
	if current_zone < total_zones:
		current_zone += 1
		get_tree().change_scene_to_file(zone_scenes[current_zone - 1])
	else:
		# All zones complete — go to final boss
		get_tree().change_scene_to_file("res://FinalBoss.tscn")

func go_to_battle():
	# Save player health before battle
	get_tree().change_scene_to_file("res://Battle.tscn")

func get_atmosphere_color() -> Color:
	# Returns a color based on current depth
	# Gets darker and more blue the deeper you go
	match current_zone:
		1: return Color(0.4, 0.6, 0.9)   # Bright blue
		2: return Color(0.2, 0.4, 0.7)   # Medium blue
		3: return Color(0.1, 0.2, 0.5)   # Dark blue
		4: return Color(0.05, 0.05, 0.2) # Almost black
		5: return Color(0.0, 0.0, 0.0)   # Pure black
		_: return Color(0.4, 0.6, 0.9)