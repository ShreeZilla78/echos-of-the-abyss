extends Node2D

var last_location
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Diver")
	last_location = player.global_position
