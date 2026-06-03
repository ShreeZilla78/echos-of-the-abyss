# Enemy.gd
extends CharacterBody2D

# Enemy states
enum State { IDLE, CHASE, ATTACK }
var current_state: State = State.IDLE

# Settings you can change per enemy in the Inspector
@export var enemy_type: String = "basic"
@export var enemy_id: String

@export var move_speed: float = 60.0
@export var detection_range: float = 200.0  # how close before chasing
@export var attack_range: float = 100.0     # how close before attacking
@export var spawn_point: Vector2            # where this enemy starts

var max_health = 50
var health = 50
var damage = 15

var player: CharacterBody2D = null
var battle_triggered: bool = false

func _ready():
	if self in MapManager.defeated_enemies:
		queue_free()
		return
	
	# Remember where this enemy spawned
	spawn_point = global_position
	# Find the player node in the scene
	player = get_tree().get_first_node_in_group("player")
	
func _physics_process(_delta):
	if player == null or battle_triggered:
		return
	
	match current_state:
		State.IDLE:   idle_behavior()
		State.CHASE:  chase_behavior()
		#State.ATTACK: attack_behavior()

func idle_behavior():
	# Check if player is close enough to start chasing
	var distance_to_player = global_position.distance_to(player.global_position)
	if distance_to_player < detection_range:
		current_state = State.CHASE
		print("Enemy spotted the diver!")

func chase_behavior():
	if self not in MapManager.current_enemy_ids:
			MapManager.current_enemy_ids.append(self)
	
	var distance_to_player = global_position.distance_to(player.global_position)
	
	# If player got away go back to idle
	if distance_to_player > detection_range * 1.5:
		current_state = State.IDLE
		return
	
	# If close enough attack
	if distance_to_player <= attack_range:
		current_state = State.ATTACK
		return
	
	# Move toward the player
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * move_speed
	move_and_slide()
	
	# Flip sprite to face player
	if direction.x > 0:
		#$Sprite2D.flip_h = false
		pass
	else:
		#$Sprite2D.flip_h = true
		pass
		
func attack_behavior():
	# Keep this the chase behaviour for now
	chase_behavior()
		
func _on_body_entered(_body):
	pass

func return_to_spawn():
	# Called when player escapes — enemy walks back to start
	global_position = spawn_point
	current_state = State.IDLE
	battle_triggered = false

func take_damage(damage_to_take: int = 0):
	health -= damage_to_take
	health = clampi(health, 0, max_health)
			
	if health == 0:		
		MapManager.defeated_enemies.append(self)
		MapManager.current_enemy_ids.erase(self)
		queue_free()
