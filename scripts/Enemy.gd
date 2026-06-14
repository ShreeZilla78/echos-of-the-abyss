# Enemy.gd
extends CharacterBody2D

# Enemy states
enum State { IDLE, CHASE, ATTACK, STUN }
var current_state: State = State.IDLE
var stun_duration: float = 0.0

# Settings you can change per enemy in the Inspector
@export var enemy_type: String = "basic"
@export var enemy_id: String

@export var move_speed: float = 60.0
@export var detection_range: float = 200.0  # how close before chasing
@export var attack_range: float = 140.0     # how close before attacking
@export var spawn_point: Vector2            # where this enemy starts

var max_health = 50
var health = 50
var damage = 15

var distance_to_player

@onready var sprite: TextureRect = $TextureRect
var sprite_original_modulate: Color = Color.WHITE

var player: CharacterBody2D = null
var battle_triggered: bool = false

var attack_cooldown = 0.0
var frame_delta

func _ready():
	if self in MapManager.defeated_enemies:
		queue_free()
		return
		
	if self not in MapManager.current_enemy_ids:
		MapManager.current_enemy_ids.append(self)
	
	# Remember where this enemy spawned
	spawn_point = global_position
	# Find the player node in the scene
	player = get_tree().get_first_node_in_group("player")
	# Remember the original sprite tint so the flash can return to it
	sprite_original_modulate = sprite.modulate
	
func _physics_process(delta):
	if player == null or battle_triggered:
		return
		
	frame_delta = delta
		
	distance_to_player = self.global_position.distance_to(player.global_position)

	match current_state:
		State.IDLE:   idle_behavior()
		State.CHASE:  chase_behavior()
		State.ATTACK: attack_behavior()
		State.STUN:	  stun_behaviour()

func idle_behavior():
	# Check if player is close enough to start chasing	
	if distance_to_player < detection_range:
		current_state = State.CHASE

func chase_behavior():	
	# If player got away go back to idle
	if distance_to_player > detection_range * 1.5:
		current_state = State.IDLE
		return
	
	# If close enough attack
	if distance_to_player <= attack_range:
		current_state = State.ATTACK
		return
	
	# Move toward the player
	var direction = (player.global_position - self.global_position).normalized()
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
	# If player got away go back to idle
	if distance_to_player > detection_range * 1.5:
		current_state = State.IDLE
		return
	
	if distance_to_player > attack_range:
		current_state = State.CHASE
		return
		
	if attack_cooldown == 0.0:		
		player.take_damage(damage)
		flash_black()
		attack_cooldown = 0.7
	else:
		attack_cooldown -= frame_delta
		attack_cooldown = clampf(attack_cooldown, 0.0, 0.7)
				
	# Move toward the player
	var direction = (player.global_position - self.global_position).normalized()
	velocity = direction * move_speed
	move_and_slide()
		
func stun_behaviour():
	stun_duration -= frame_delta
	
	if stun_duration <= 0.0:
		current_state = State.CHASE

func stun(duration: float):
	current_state = State.STUN
	stun_duration = duration

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
	flash_white()
				
	if health == 0:		
		MapManager.defeated_enemies.append(self)
		MapManager.current_enemy_ids.erase(self)
		queue_free()
		
func heal(health_to_heal: int = 0):
	health += health_to_heal
	health = clampi(health, 0, max_health)

func flash_white():
	sprite.modulate = Color(1, 1, 1, 1)
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", sprite_original_modulate, 0.1)
	await tween.finished

func flash_black():
	sprite.modulate = Color(0, 0,0,1)
	var tween =  create_tween()
	tween.tween_property(sprite, "modulate", sprite_original_modulate, 0.1)
	await tween.finished
