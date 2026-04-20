# Card.gd
class_name Card
extends Resource

@export var card_name: String = ""
@export var description: String = ""
@export var air_cost: int = 1        # "mana" but themed as oxygen
@export var damage: int = 0
@export var block: int = 0
@export var heal: int = 0

# This runs when the card hits the discard pile
func on_discard(battle):
	pass  # We'll fill this in later for each card's special event