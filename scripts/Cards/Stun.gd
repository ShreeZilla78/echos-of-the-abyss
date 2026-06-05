class_name Stun
extends Card


# Called when the node enters the scene tree for the first time.
func _init():
	card_name = "Stun"
	description = "Stuns an enemy and deals damage, preventing them from acting on their next turn."
	damage = 10
	air_cost = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_play(_player: Player):
	pass
