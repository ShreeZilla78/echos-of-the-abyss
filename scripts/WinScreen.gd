# WinScreen.gd
extends Control

@onready var result_label = $ResultLabel
@onready var continue_button = $Button

func _ready():
	result_label.text = "The creature retreats into the abyss...\nVictory!"
	continue_button.text = "Dive Deeper"
	continue_button.pressed.connect(continue_game)

func continue_game():
	MapManager.defeated_enemies.append(MapManager.current_enemy_id)
	MapManager.return_to_map()
