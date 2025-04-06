extends Node2D

@onready var tilemap = $Earth
@onready var player = $Player

func _physics_process(delta: float) -> void:
	if player.global_position.x >= 485.0:
		player.global_position.x = -480
	elif player.global_position.x <= -485.0:
		player.global_position.x = 480
		
	if Input.is_action_just_pressed("swing"):
		delete_tile()
	
func delete_tile():
	print("delete")
	var mouse_pos = get_global_mouse_position()
	var tile_mouse_pos = tilemap.local_to_map(mouse_pos)
	print(tile_mouse_pos)
	
	tilemap.erase_cell(tile_mouse_pos)
