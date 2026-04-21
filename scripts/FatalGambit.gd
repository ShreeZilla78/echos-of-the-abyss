# FatalGambit.gd
class_name FatalGambit
extends Card

func _init():
	card_name = "The Fatal Gambit"
	description = "50/50. Absolute victory or absolute demise."
	air_cost = 0
	damage = 0
	block = 0
	heal = 0

func on_discard(battle):
	# Rolls the dice — 50/50
	var roll = randi() % 2
	
	if roll == 0:
		# Victory — instantly kill the enemy
		print("The Fatal Gambit activates... VICTORY!")
		battle.apply_damage(battle.enemy_health)
	else:
		# Defeat — instantly kill the player
		print("The Fatal Gambit activates... DEFEAT!")
		battle.player_health = 0
		battle.update_ui()
		battle.check_battle_end()