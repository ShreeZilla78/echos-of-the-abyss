# CardUI.gd
extends Panel

signal card_clicked(card)

var card_data: Card

func setup(card: Card):
	card_data = card
	$Name.text = card.card_name
	$AirCost.text = str(card.air_cost)
	# If the card has an image assigned show it
	#if card.card_image != null:
		#$CardImg.texture = card.card_image

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			emit_signal("card_clicked", card_data)

func _ready():
	pass
	# add this so the cards dont get too tiny
	#custom_minimum_size = Vector2(120, 160)
