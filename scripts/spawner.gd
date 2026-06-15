extends Node2D


@export var enemy_scene: PackedScene

func _on_timer_timeout():
	var enemy = enemy_scene.instantiate()
	enemy.position = position
	get_parent().add_child(enemy)