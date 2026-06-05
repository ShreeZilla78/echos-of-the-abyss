# Card.gd
class_name Card
extends Resource

@export var diverBell: String = "Diver's Bell"  # Placeholder for card image or identifier
@export var card_name: String = "Card Name" # Placeholder for card name
@export var description: String = ""
@export var air_cost: int = 1        # "mana" but themed as oxygen
@export var damage: int = 0
@export var block: int = 0
@export var heal: int = 0
@export var card_image: Texture2D = null

<<<<<<< HEAD
func on_play(_player: Player):
	pass
=======
func on_play(context: Battle):
	context.apply_damage(self.damage)
	context.player_gain_block(self.block)
	context.player_heal(self.heal)
>>>>>>> d42064860bbfedc6d794e37246c6a8094e6fc8c4

# This runs when the card hits the discard pile
func on_discard():
	# By default, do nothing. Override in specific cards if needed.
	pass
