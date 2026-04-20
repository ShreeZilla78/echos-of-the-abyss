# DeckManager.gd
class_name DeckManager
extends Node

# The three piles that make up the card system
var draw_pile: Array[Card] = []
var hand: Array[Card] = []
var discard_pile: Array[Card] = []

func shuffle_draw_pile():
	draw_pile.shuffle()

func draw_card(amount: int = 1):
	for i in amount:
		# If draw pile is empty, recycle the discard pile
		if draw_pile.is_empty():
			recycle_discard()
		if not draw_pile.is_empty():
			hand.append(draw_pile.pop_back())

func play_card(card: Card, battle):
	hand.erase(card)
	# Apply the card's effects to the battle
	battle.apply_damage(card.damage)
	battle.player_gain_block(card.block)
	battle.player_heal(card.heal)
	# Move to discard pile and fire the discard event
	discard_pile.append(card)
	card.on_discard(battle)

func recycle_discard():
	# Shuffle discard pile back into the draw pile when draw pile runs out
	draw_pile = discard_pile.duplicate()
	discard_pile.clear()
	shuffle_draw_pile()