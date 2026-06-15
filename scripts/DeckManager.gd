# DeckManager.gd
class_name DeckManager
extends Node

# The three piles that make up the card system
var draw_pile: Array[Card] = []
var hand: Array[Card] = []
var discard_pile: Array[Card] = []

func shuffle_draw_pile():
	draw_pile.shuffle()

func draw_card(index: int, amount: int = 1):
	for i in amount:
		# If draw pile is empty, recycle the discard pile
		if draw_pile.is_empty():
			recycle_discard()
		if not draw_pile.is_empty():
			hand.insert(index, draw_pile.pop_front())

func play_card(card: Card, player: Player):
	hand.erase(card)
	# Apply the card's effects to the battle
	card.on_play(player)
	# Move to discard pile and fire the discard event
	discard_pile.append(card)
	card.ui.on_discard()
	
func recycle_discard():
	# Shuffle discard pile back into the draw pile when draw pile runs out
	draw_pile = discard_pile.duplicate()
	discard_pile.clear()
	shuffle_draw_pile()
