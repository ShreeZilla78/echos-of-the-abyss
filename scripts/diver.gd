# Player.gd
class_name Player
extends CharacterBody2D

# How fast the diver moves
@export var move_speed: int = 100

# Pixel art needs this to look crisp
@export var pixel_size: int = 2

func _ready():
	# Make camera follow player smoothly
	$Camera.make_current()
	$Camera.position_smoothing_enabled = true
	$Camera.position_smoothing_speed = 5.0
	# Set how far the camera can scroll
	$Camera.limit_left = 0
	$Camera.limit_top = 0
	$Camera.limit_right = 3000
	$Camera.limit_bottom = 3000

func _physics_process(delta):
	# Get keyboard input
	var direction = Vector2.ZERO
	
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
	
	# Flip sprite based on direction
	if direction.x > 0:
		$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/east.png")
	elif direction.x < 0:
		$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/west.png")
		
	if direction.y > 0:
		$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/south.png")
	elif direction.y < 0:
		$Sprite.texture = load("res://assets/AdvancedDiverPlaceholderArt/north.png")
