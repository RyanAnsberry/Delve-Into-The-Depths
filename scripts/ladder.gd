extends Area2D

@onready var collision_shape = $CollisionShape2D

signal entered_ladder
signal exited_ladder

#func _ready() -> void:
	#collision_shape.disabled = true

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		entered_ladder.emit()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		exited_ladder.emit()
