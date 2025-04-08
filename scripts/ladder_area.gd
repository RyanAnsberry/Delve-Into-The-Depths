extends Area2D
class_name Ladder_Area

@onready var collision_shape = $CollisionShape2D

signal ladder_entered
signal ladder_exited

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("ladder entered")
		ladder_entered.emit()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		print("ladder exited")
		ladder_exited.emit()

func expand_area_up():
	var collision_vertical_pos = collision_shape.transform.position
	collision_vertical_pos -= 7
	var collision_shape_vertical_size = collision_shape.shape.size.y
	collision_shape_vertical_size *= 2

func expand_area_down():
	var collision_vertical_pos = collision_shape.transform.position
	collision_vertical_pos += 7
	var collision_shape_vertical_size = collision_shape.shape.size.y
	collision_shape_vertical_size *= 2
