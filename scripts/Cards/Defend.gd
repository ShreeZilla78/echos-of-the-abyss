# Defend.gd
class_name Defend
extends Card

func _init():
	card_name = "Defend"
	description = "Reduces damage."
	air_cost = 1
	damage = 0
	block = 5
	heal = 0

<<<<<<< HEAD
func on_play(player: Player):	
	player.increase_block(self.block)
=======
func on_play(context: Battle):	
	context.player.increase_block(self.block)
	
>>>>>>> d42064860bbfedc6d794e37246c6a8094e6fc8c4
