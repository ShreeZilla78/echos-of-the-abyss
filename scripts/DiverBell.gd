# DiverBell.gd
class_name DiverBell
extends Card

func _init():
	card_name = "Diver Bell"
	description = "Skip current battle but, the next enemy will have 30% more health."
	air_cost = 2
	damage = 0
	block = 10
	heal = 0

func on_play(battle):
	# Apply the block immediately
	battle.player_gain_block(block)
	# Set the next battle's health multiplier in MapManager
	MapManager.next_enemy_health_multiplier = 1.3
	MapManager.return_to_map() #skips the battle and returns to the map
	