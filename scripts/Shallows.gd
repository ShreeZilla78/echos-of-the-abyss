# Shallows.gd
extends Node2D

var deck: DeckManager

@onready var health_bar = $UI/HealthBar
@onready var hand_container = $UI/HandContainer
@onready var player = $Diver

@export var cards_in_hand: int = 3

var slot_cooldowns: Array[float] = [0.0, 0.0, 0.0]

@export var slot_cooldown_duration: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	#health_label.text = "Health:" + str(player_health) + "/" + str(player_max_health)
	health_bar.max_value = PlayerStats.max_health
	health_bar.value = PlayerStats.health
	
	# Set up deck
	deck = DeckManager.new()
	add_child(deck)
	add_starter_cards()
	
func _process(delta):	
	for i in range(len(slot_cooldowns)):
		if slot_cooldowns[i] > 0.0:
			slot_cooldowns[i] -= delta
	
	var number = 0
	for card_ui in hand_container.get_children():
		card_ui.cooldown_bar.value = slot_cooldowns[number]
		number += 1
	
	health_bar.value = PlayerStats.health

	if Input.is_action_just_pressed("Activate Card Slot 1"):
		if deck.hand.size() > 0 and slot_cooldowns[0] <= 0.0:
			self.try_play_card(0)
	elif Input.is_action_just_pressed("Activate Card Slot 2"):
		if deck.hand.size() > 0 and slot_cooldowns[1] <= 0.0:
			self.try_play_card(1)
	elif Input.is_action_just_pressed("Activate Card Slot 3"):
		if deck.hand.size() > 0 and slot_cooldowns[2] <= 0.0:
			self.try_play_card(2)

func add_starter_cards():
	for i in 5:
		var strike = Strike.new()
		deck.draw_pile.append(strike)
		
	for i in 5:
		var defend = Defend.new()
		deck.draw_pile.append(defend)
		
	for i in 1:
		var fatal_gambit = FatalGambit.new()
		deck.draw_pile.append(fatal_gambit)
		
	for i in 3:
		var stun = Stun.new()
		deck.draw_pile.append(stun)
		
	deck.shuffle_draw_pile()
	deck.draw_card(0, cards_in_hand)
	
	for card in deck.hand:
		var card_ui = preload("res://scenes/CardUI.tscn").instantiate()
		
		card_ui.setup(card)
		card_ui.card_clicked.connect(try_play_card)
		
		hand_container.add_child(card_ui)

func update_hand_display():	
	for child in hand_container.get_children():
		child.queue_free()
	
	for card in deck.hand:
		var card_ui = preload("res://scenes/CardUI.tscn").instantiate()
		
		card_ui.setup(card)
		card_ui.card_clicked.connect(try_play_card)
		
		hand_container.add_child(card_ui)

func try_play_card(slot: int):			
	deck.play_card(deck.hand[slot], player)
	deck.draw_card(slot, 1)
	
	slot_cooldowns[slot] = slot_cooldown_duration
	
	#update_ui()
	update_hand_display()
	#check_battle_end()
