# MapManager.gd
extends Node

# This script persists between ALL scenes

# Track which zone the player is in
var current_zone: int = 0
var total_zones: int = 5

# Player stats that carry between zones
var player_starting_max_health: int = 50
var player_deck: Array = []

# Enemy info for battles
var current_enemy: String = "basic"
var current_enemy_id: String
var defeated_enemies: Array = []

var last_checkpoint_position: Vector2 = Vector2.ZERO
var battle_position_save: Vector2 = Vector2.ZERO

var battle_ended: bool = false

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
		call_deferred("_change_to_zone", current_zone)
	else:
		call_deferred("_go_to_final_boss")

func _change_to_zone(zone_index):
	get_tree().change_scene_to_file(zone_scenes[zone_index])

func _go_to_final_boss():
	get_tree().change_scene_to_file("res://scenes/FinalBoss.tscn")

func go_to_battle():
	call_deferred("_change_to_battle")
	
func _change_to_battle():
	get_tree().change_scene_to_file("res://scenes/Battle.tscn")

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
	PlayerStats.max_health = player_starting_max_health
	player_deck.clear()
	get_tree().change_scene_to_file(zone_scenes[current_zone])

func return_to_map():
	# After battle, return to current zone
	get_tree().change_scene_to_file(zone_scenes[current_zone])
