# FatalGambit.gd
class_name FatalGambit
extends Card

func _init():
	card_name = "Fatal Gambit"
	description = "50/50. Absolute victory or absolute demise."
	air_cost = 3
	damage = 0
	block = 0
	heal = 0

func on_play(player: Player):
	var enemy
	
	if MapManager.current_enemy_ids.size() > 0:
		enemy = MapManager.current_enemy_ids[0]
	else:
		return
	
	if enemy in MapManager.defeated_enemies:
		return
			
	var distance_to_enemy = player.player.global_position.distance_to(enemy.global_position)
	
	#Makes it wait for the white flash
	await Utility.flash_screen(Color.WHITE)

	var roll = randi() % 2
	
	if roll == 0:
		await Utility.flash_screen(Color.BLUE)
		
		if distance_to_enemy <= PlayerStats.attack_range:
			enemy.take_damage(enemy.health)
			
		#await Utility.show_event_message("The Gambit pays off... The creature is destroyed!")
		
	else:
		await Utility.flash_screen(Color.RED)
		player.take_damage(PlayerStats.health)
		enemy.heal(enemy.max_health)
			
		#await Utility.show_event_message("The Gambit fails... The abyss takes you.")
		#Utility.player_health = 0
		#Utility.update_ui()
		#Utility.check_battle_end()
