# Battle.gd
class_name Battle
extends Node

var DeckManager = preload("res://DeckManager.gd")

# Player stats
var player_max_health: int = 50
var player_max_air: int = 3
var player_health: int
var player_air: int
var player_block: int = 0

# Enemy stats
var enemy_health: int = 30
var enemy_max_health: int = 30
var enemy_damage: int = 8

var is_player_turn: bool = true
var deck: DeckManager

# These connect the script to the nodes in your scene panel
# The $ path must match your node names exactly
@onready var health_label = $UI/PlayerStats/HealthLabel
@onready var health_bar = $UI/PlayerStats/HealthBar
@onready var air_label = $UI/PlayerStats/AirLabel
@onready var air_bar = $UI/PlayerStats/AirBar
@onready var hand_container = $UI/HandContainer
@onready var enemy_health_label = $UI/EnemyHealthLabel
@onready var enemy_health_bar = $UI/EnemyHealthProgressBar
@onready var end_turn_button = $UI/EndTurnButton

func _ready():
	player_health = player_max_health
	player_air = player_max_air
	# Set up the progress bars max values
	health_label.text = "Health:" + str(player_health) + "/" + str(player_max_health)
	health_bar.max_value = player_max_health
	air_bar.max_value = player_max_air
	air_label.text = "Air: " + str(player_air) + "/" + str(player_max_air)
	# Connect the end turn button so clicking it calls end_turn()
	end_turn_button.text = "End Turn"
	end_turn_button.pressed.connect(end_turn)
	enemy_health_bar.max_value = enemy_max_health
	# Set up deck
	deck = DeckManager.new()
	add_child(deck)
	# Add starter cards so we have something to test with
	add_starter_cards()
	update_ui()
	start_turn()

func add_starter_cards():
	# A basic starter deck — 5 attack cards and 3 defend cards
	for i in 5:
		var card = Card.new()
		card.card_name = "Strike"
		card.description = "Deal 6 damage"
		card.air_cost = 1
		card.damage = 6
		deck.draw_pile.append(card)
	for i in 3:
		var card = Card.new()
		card.card_name = "Defend"
		card.description = "Gain 4 block"
		card.air_cost = 1
		card.block = 4
		deck.draw_pile.append(card)
	deck.shuffle_draw_pile()

func start_turn():
	player_air = player_max_air
	player_block = 0
	deck.draw_card(5)
	is_player_turn = true
	update_ui()
	update_hand_display()

func update_ui():
	# Update all UI elements to reflect current game state
	health_label.text = "Health: " + str(player_health) + "/" + str(player_max_health)
	health_bar.value = player_health
	air_label.text = "Air: " + str(player_air) + "/" + str(player_max_air)
	air_bar.value = player_air
	enemy_health_label.text = "Enemy HP: " + str(enemy_health) + "/" + str(enemy_max_health)
	enemy_health_bar.value = enemy_health

func update_hand_display():
	# Clear old card buttons
	for child in hand_container.get_children():
		child.queue_free()
	# Create a button for each card in hand
	for card in deck.hand:
		var button = Button.new()
		button.text = card.card_name + "\nCost: " + str(card.air_cost)
		button.custom_minimum_size = Vector2(100, 120)
		# When clicked, try to play that card
		button.pressed.connect(try_play_card.bind(card))
		hand_container.add_child(button)

func try_play_card(card: Card):
	if not is_player_turn:
		return
	if player_air < card.air_cost:
		print("Not enough air!")
		return
	player_air -= card.air_cost
	deck.play_card(card, self)
	update_ui()
	update_hand_display()
	check_battle_end()

func end_turn():
	is_player_turn = false
	# Discard remaining hand
	for card in deck.hand.duplicate():
		deck.discard_pile.append(card)
		card.on_discard(self)
	deck.hand.clear()
	update_hand_display()
	enemy_take_turn()

func enemy_take_turn():
	var damage_after_block = max(0, enemy_damage - player_block)
	player_health -= damage_after_block
	player_block = 0
	update_ui()
	check_battle_end()
	if player_health > 0:
		start_turn()

func apply_damage(amount: int):
	enemy_health -= amount
	update_ui()

func player_gain_block(amount: int):
	player_block += amount
	update_ui()

func player_heal(amount: int):
	player_health = min(player_max_health, player_health + amount)
	update_ui()

func check_battle_end():
	if enemy_health <= 0:
		print("Victory! The creature retreats into the abyss...")
		end_turn_button.disabled = true
		get_tree().change_scene_to_file("res://WinScreen.tscn")
	elif player_health <= 0:
		print("The abyss claims another soul...")
		end_turn_button.disabled = true
		get_tree().change_scene_to_file("res://LoseScreen.tscn")
