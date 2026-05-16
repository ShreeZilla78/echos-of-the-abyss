# Enemy.gd
extends Area2D

@export var enemy_type: String = "basic"
@export var enemy_id: String
var battle_triggered: bool = false

func _ready():
	if enemy_id in MapManager.defeated_enemies:
		queue_free() # completely removes it
		return
	
	body_entered.connect(on_player_entered)
	
func on_player_entered(body):
	if body is Player and not battle_triggered:
		battle_triggered = true
		MapManager.battle_position_save = body.global_position
		# Save which enemy was encountered so Battle knows who to fight
		MapManager.current_enemy = enemy_type
		MapManager.current_enemy_id = enemy_id
		# Go to battle scene
		MapManager.go_to_battle()
