# CardUI.gd
class_name CardUI
extends Panel

signal card_clicked(card)

var card_data: Card
var self_color_modulate: Color = Color(1, 1, 1, 1)

@onready var cooldown_bar= $Cooldown

func setup(card: Card):
	card_data = card
	card_data.ui = self
	
	$Name.text = card.card_name
	$AirCost.text = str(card.air_cost)
	# If the card has an image assigned show it
	#if card.card_image != null:
		#$CardImg.texture = card.card_image

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			emit_signal("card_clicked", card_data)
			
func on_discard():
	self.modulate = Color(0, 0,0,1)
	var tween = create_tween()
	tween.tween_property(self, "modulate", self_color_modulate, 0.1)
	await tween.finished

func _ready():
	# add this so the cards dont get too tiny
	custom_minimum_size = Vector2(96, 144)
