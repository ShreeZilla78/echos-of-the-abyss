# ZoneBase.gd
extends Node2D

@onready var exit_zone = $ExitZone

func _ready():
	# Apply atmosphere color based on depth
	var atmosphere = MapManager.get_atmosphere_color()
	RenderingServer.set_default_clear_color(atmosphere)
	# Restore player health from MapManager
	$Diver.camera.limit_right = 1536
	$Diver.camera.limit_bottom = 864
	# Connect exit zone
	exit_zone.body_entered.connect(on_player_reached_exit)

func on_player_reached_exit(body):
	if body is Player:
		print("Zone complete! Diving deeper...")
		MapManager.go_to_next_zone()
