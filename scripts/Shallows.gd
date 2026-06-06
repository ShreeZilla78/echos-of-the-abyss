# Shallows.gd
extends Node2D

var deck: DeckManager

@onready var health_bar = $UI/HealthBar
@onready var hand_container = $UI/HandContainer
@onready var player = $Diver

@export var cards_in_hand: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	#health_label.text = "Health:" + str(player_health) + "/" + str(player_max_health)
	health_bar.max_value = PlayerStats.max_health
	health_bar.value = PlayerStats.health
	
	# Set up deck
	deck = DeckManager.new()
	add_child(deck)
	add_starter_cards()
	
func _process(_delta):
	for card in deck.hand:
		if card.current_cooldown > 0.0:
			card.current_cooldown -= _delta
	health_bar.value = PlayerStats.health

	if Input.is_action_just_pressed("Activate Card Slot 1"):
		if deck.hand.size() > 0 and deck.hand[0].current_cooldown <= 0.0:
			self.try_play_card(deck.hand[0])
	elif Input.is_action_just_pressed("Activate Card Slot 2"):
		if deck.hand.size() > 0 and deck.hand[1].current_cooldown <= 0.0:
			self.try_play_card(deck.hand[1])
	elif Input.is_action_just_pressed("Activate Card Slot 3"):
		if deck.hand.size() > 0 and deck.hand[2].current_cooldown <= 0.0:
			self.try_play_card(deck.hand[2])
	elif Input.is_action_just_pressed("Activate Card Slot 4"):
		if deck.hand.size() > 0 and deck.hand[3].current_cooldown <= 0.0:
			self.try_play_card(deck.hand[3])
	elif Input.is_action_just_pressed("Activate Card Slot 5"):
		if deck.hand.size() > 0 and deck.hand[4].current_cooldown <= 0.0:
			self.try_play_card(deck.hand[4])

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
	deck.draw_card(cards_in_hand)
	
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

func try_play_card(card: Card):	
	card.current_cooldown = card.cooldown
	deck.play_card(card, player)
	deck.draw_card(1)
	
	#update_ui()
	update_hand_display()
	#check_battle_end()
