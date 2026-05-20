extends Area2D

func _ready():
	pass
	
func _process(_delta):
	pass

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		MapManager.last_checkpoint_position = $RespawnPoint.global_position
