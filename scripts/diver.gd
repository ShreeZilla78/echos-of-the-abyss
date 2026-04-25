# Player.gd
class_name Player
extends CharacterBody2D

# How fast the diver moves
@export var move_speed: int = 200
# Pixel art needs this to look crisp
@export var pixel_size: int = 2
@export var dash_speed: int = 2

@onready var camera = $Camera2D

func _ready():
	$Camera.enabled = false
	# Make camera follow player smoothly
	camera.make_current()
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 5.0
	# Set how far the camera can scroll
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = 1532
	camera.limit_bottom = 1023

func _physics_process(delta):	
	var direction = Vector2.ZERO

	if Input.is_action_pressed("Sprint"):
		move_speed += 75
		
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
	velocity = direction * move_speed
	move_and_slide()
	
	move_speed = 200

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
