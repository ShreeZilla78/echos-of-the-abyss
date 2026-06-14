# Card.gd
class_name Card
extends Panel

@export var card_name: String = "Card Name" # Placeholder for card name
@export var description: String = ""
@export var air_cost: int = 1        # "mana" but themed as oxygen
@export var damage: int = 0
@export var block: int = 0
@export var heal: int = 0
@export var card_image: Texture2D = null

var ui: CardUI = null

var cooldown: float = 0.0
var current_cooldown: float = 0.0		# Sets the current cooldown and keeps track of the cooldown duration

func on_play(_player: Player):
	pass
