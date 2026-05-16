# Shallows.gd
extends Node2D

@onready var health_bar = $UI/HealthBar

# Called when the node enters the scene tree for the first time.
func _ready():
	#health_label.text = "Health:" + str(player_health) + "/" + str(player_max_health)
	health_bar.max_value = PlayerStats.max_health
	health_bar.value = PlayerStats.health
