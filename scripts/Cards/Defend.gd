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

func on_play(context: Battle):	
	context.player.increase_block(self.block)
	
