# Surface.gd
# The starting area — land, bridge, and the ocean entry point
extends Node2D

@onready var exit_zone = $ExitZone

func _ready():
	# Bright surface colors — this is before the dive
	RenderingServer.set_default_clear_color(MapManager.get_atmosphere_color())
	# Connect exit zone to trigger descent
	exit_zone.body_entered.connect(on_player_entered_ocean)

func on_player_entered_ocean(body):
	if body is Player:
		print("The diver takes a breath and descends...")
		MapManager.go_to_next_zone()
