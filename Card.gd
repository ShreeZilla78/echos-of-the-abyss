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

# This runs when the card hits the discard pile
func on_discard(battle):
	# By default, do nothing. Override in specific cards if needed.
	pass