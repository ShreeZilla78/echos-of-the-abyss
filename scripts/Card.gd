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

func on_play(battle):
	battle.apply_damage(self.damage)
	battle.player_gain_block(self.block)
	battle.player_heal(self.heal)

# This runs when the card hits the discard pile
func on_discard(_battle):
	# By default, do nothing. Override in specific cards if needed.
	pass
