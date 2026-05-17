# Enemy.gd
extends CharacterBody2D

# Enemy states
enum State { IDLE, CHASE, ATTACK }
var current_state: State = State.IDLE

# Settings you can change per enemy in the Inspector
@export var enemy_type: String = "basic"
@export var move_speed: float = 60.0
@export var detection_range: float = 200.0  # how close before chasing
@export var attack_range: float = 30.0      # how close before attacking
@export var spawn_point: Vector2            # where this enemy starts

var player: CharacterBody2D = null
var battle_triggered: bool = false

func _ready():
	# Remember where this enemy spawned
	spawn_point = global_position
	# Find the player node in the scene
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player == null or battle_triggered:
		return
	
	match current_state:
		State.IDLE:   idle_behavior()
		State.CHASE:  chase_behavior()
		State.ATTACK: attack_behavior()

func idle_behavior():
	# Check if player is close enough to start chasing
	var distance_to_player = global_position.distance_to(player.global_position)
	if distance_to_player < detection_range:
		current_state = State.CHASE
		print("Enemy spotted the diver!")

func chase_behavior():
	var distance_to_player = global_position.distance_to(player.global_position)
	
	# If player got away go back to idle
	if distance_to_player > detection_range * 1.5:
		current_state = State.IDLE
		return
	
	# If close enough attack
	if distance_to_player < attack_range:
		current_state = State.ATTACK
		return
	
	# Move toward the player
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * move_speed
	move_and_slide()
	
	# Flip sprite to face player
	if direction.x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true

func attack_behavior():
	if battle_triggered:
		return
	battle_triggered = true
	# Save player health and go to battle
	MapManager.current_enemy = enemy_type
	MapManager.player_health = player.health
	MapManager.go_to_battle()

func return_to_spawn():
	# Called when player escapes — enemy walks back to start
	global_position = spawn_point
	current_state = State.IDLE
	battle_triggered = false
