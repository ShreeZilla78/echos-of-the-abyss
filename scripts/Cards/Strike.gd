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

func on_play(player: Player):	
	player.attack()
