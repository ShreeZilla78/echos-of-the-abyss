# LooseScene.gd
extends Control

@onready var result_label = $ResultLabel
@onready var continue_button = $ReturnButton

func _ready():
	result_label.text = "Your flame has been snuffed out!"
	continue_button.text = "Return to Sender"
	continue_button.pressed.connect(continue_game)

func continue_game():
	# This file does not exist, replace with MapManager.return_to_last_rest() when completed
	#get_tree().change_scene_to_file("res://scenes/world_map.tscn")
	PlayerStats.health = PlayerStats.max_health
	
	MapManager.return_to_map()
