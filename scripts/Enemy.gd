# EnemySpot.gd
extends Area2D

@export var enemy_type: String = "basic"
var battle_triggered: bool = false

func _ready():
	body_entered.connect(on_player_entered)

func on_player_entered(body):
	if body is Player and not battle_triggered:
		battle_triggered = true
		# Save which enemy was encountered so Battle knows who to fight
		MapManager.current_enemy = enemy_type
		# Go to battle scene
		MapManager.go_to_battle()
