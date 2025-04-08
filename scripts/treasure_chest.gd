extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

var empty = false

signal collected

func _on_body_entered(body: Node2D) -> void:
	if body is Player and !empty:
		open_chest()
		collected.emit()

func open_chest():
	empty = true
	animated_sprite.play("open")
	await get_tree().create_timer(0.6).timeout
	animated_sprite.play("empty")
