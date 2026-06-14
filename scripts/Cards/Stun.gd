class_name Stun
extends Card


# Called when the node enters the scene tree for the first time.
func _init():
	card_name = "Stun"
	description = "Stuns an enemy and deals damage, preventing them from acting on their next turn."
	damage = 10
	air_cost = 1
	cooldown = 0.5

func on_play(player: Player):
	for enemy in MapManager.current_enemy_ids:
		if enemy in MapManager.defeated_enemies:
			continue
			
		var distance = player.global_position.distance_to(enemy.global_position)
		
		if distance <= PlayerStats.attack_range:
			enemy.take_damage(damage)
			enemy.stun(0.5)
