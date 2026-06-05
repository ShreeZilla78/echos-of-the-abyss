# Strike.gd
class_name Strike
extends Card

func _init():
	card_name = "Strike"
	description = "Deals damage."
	air_cost = 1
	damage = 20
	block = 0
	heal = 0

<<<<<<< HEAD
func on_play(player: Player):	
	player.attack()
=======
func on_play(battle: Battle):
	battle.apply_damage(damage)	
	for enemy in MapManager.current_enemy_ids:
		if enemy in MapManager.defeated_enemies:
			continue
			
		var distance_to_enemy = battle.player.global_position.distance_to(enemy.global_position)
		
		if distance_to_enemy <= PlayerStats.attack_range:
			enemy.take_damage(damage)
			
>>>>>>> d42064860bbfedc6d794e37246c6a8094e6fc8c4
