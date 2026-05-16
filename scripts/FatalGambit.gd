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

func on_play(battle):
	#Makes it wait for the white flash
	await battle.flash_screen(Color.WHITE)

	var roll = randi() % 2
	
	if roll == 0:
		await battle.flash_screen(Color.BLUE)
		await battle.show_event_message("The Gambit pays off... The creature is destroyed!")
		battle.apply_damage(battle.enemy_health)
	else:
		await battle.flash_screen(Color.RED)
		await battle.show_event_message("The Gambit fails... The abyss takes you.")
		battle.player_health = 0
		battle.update_ui()
		battle.check_battle_end()
