extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func flash_screen(color: Color):
	# Create a colored overlay that fades out
	var overlay = ColorRect.new()
	overlay.color = color
	overlay.size = get_viewport().get_visible_rect().size * 100
	overlay.modulate.a = 0.8
	add_child(overlay)
	# Fade it out over 0.5 seconds
	# tween just adds the Fade in and out effect to the screen

	var tween = create_tween()
	tween.tween_property(overlay, "modulate:a", 0.0, 0.5)
	await tween.finished
	overlay.queue_free()
	
func show_event_message(message: String, event_label, time: float = 2.0):
		event_label.text = message
		event_label.visible = true
		# Wait 2 seconds then hide it
		await get_tree().create_timer(time).timeout
		event_label.visible = false
