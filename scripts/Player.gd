# Player.gd
class_name Player
extends CharacterBody2D

# removing the ability to sprint for now, can easily change later
@export var sprint_enabled: bool = false

# How fast the diver moves
@export var base_speed: int = 200
# Pixel art needs this to look crisp
@export var pixel_size: int = 2

@export var sprint_bonus: int = 75

@export var max_stamina: float = 2.0   # 2 seconds of sprint
var stamina: float = 2.0

@export var stamina_recovery_rate: float = 0.5  # seconds recovered per second
@export var stamina_drain_rate: float = 1.0     # drains 1 per second while sprinting

@onready var camera = $Camera

func _ready():
	# Make camera follow player smoothly
	camera.make_current()
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 5.0
	# Set how far the camera can scroll
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = 1532
	camera.limit_bottom = 1023
	
	if MapManager.last_checkpoint_position != Vector2.ZERO:
		go_to_position(MapManager.last_checkpoint_position)
		
	if MapManager.current_enemy_id in MapManager.defeated_enemies:
		go_to_position(MapManager.battle_position_save)
		MapManager.battle_position_save = Vector2.ZERO

func _physics_process(delta):	
	var direction = Vector2.ZERO
	var current_speed = base_speed

	if sprint_enabled:
		if Input.is_action_pressed("Sprint") and stamina > 0:
			stamina -= stamina_drain_rate * delta
			current_speed += sprint_bonus
		else:
			stamina += stamina_recovery_rate * delta
			
		stamina = clamp(stamina, 0, max_stamina)
	
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	
	# Normalize so diagonal movement isnt faster
	if direction.length() > 0:
		direction = direction.normalized()
	
	# Apply movement
	velocity = direction * current_speed
	move_and_slide()
	
	# Flip sprite based on direction
	if direction.x > 0:
		if direction.y > 0:
			$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/south-east.png")
		elif direction.y < 0:
			$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/north-east.png")
		else:
			$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/east.png")
	elif direction.x < 0:
		if direction.y > 0:
			$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/south-west.png")
		elif direction.y < 0:
			$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/north-west.png")
		else:
			$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/west.png")
		
	if direction.y > 0:
		if direction.x > 0:
			$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/south-east.png")
		elif direction.x < 0:
			$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/south-west.png")
		else:
			$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/south.png")
	elif direction.y < 0:
		if direction.x > 0:
			$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/north-east.png")
		elif direction.x < 0:
			$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/north-west.png")
		else:
			$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/north.png")

func go_to_position(pos: Vector2 = Vector2.ZERO):
	global_position = pos
