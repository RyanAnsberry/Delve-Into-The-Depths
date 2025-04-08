extends Node2D

@onready var ui = $UI
@onready var money_gui = $UI/MoneyGUI
@onready var dirt = $Tilemaps/Dirt
@onready var treasure = $Tilemaps/Treasure
@onready var highlight = $Tilemaps/Highlight
@onready var player = $Player


var money = 0

func _ready() -> void:
	money_gui.set_money_label(money)

func _physics_process(delta: float) -> void:
	if player.global_position.x >= 485.0:
		player.global_position.x = -480
	elif player.global_position.x <= -485.0:
		player.global_position.x = 480
		
	if Input.is_action_just_pressed("swing") and player.is_on_floor():
		dig()
	
	highlight.clear()
	highlight.update_range_highlight(get_nearby_tiles())
	var mouse_pos_on_map = dirt.local_to_map(get_global_mouse_position())
	if is_valid_tile(mouse_pos_on_map):
		highlight.set_target_tile(mouse_pos_on_map)

func dig():
	var mouse_pos = get_global_mouse_position()
	if is_in_range(): 
		var tile_mouse_pos = dirt.local_to_map(mouse_pos)
		
		if treasure.has_treasure(tile_mouse_pos):
			print(treasure.get_treasure_type_at_pos(tile_mouse_pos))
			add_treasure(treasure.get_treasure_type_at_pos(tile_mouse_pos))
			treasure.remove_treasure(tile_mouse_pos)
		
		if tile_mouse_pos in get_nearby_tiles():
			dirt.erase_cell(tile_mouse_pos)
			dirt.update_neighbor_tiles(tile_mouse_pos)


func is_in_range():
	var local_mouse_pos = get_local_mouse_position()
	
	var player_negative_limit = player.global_position - Vector2(player.reach, player.reach)
	var player_positive_limit = player.global_position + Vector2(player.reach, player.reach)
	
	if player_negative_limit.x <= local_mouse_pos.x and local_mouse_pos.x <= player_positive_limit.x and player_negative_limit.y <= local_mouse_pos.y  and local_mouse_pos.y <= player_positive_limit.y:
		return true
	else:
		return false

func get_nearby_tiles():
	var player_tile_pos = dirt.local_to_map(player.global_position)
	var nearby_tiles = []
	
	var surrounding_cells= [
			(player_tile_pos + Vector2i(-1, -1)), #top left
			(player_tile_pos + Vector2i(0, -1)), #top
			(player_tile_pos + Vector2i(1, -1)), #top right
			(player_tile_pos + Vector2i(-1, 0)), #left
			(player_tile_pos + Vector2i(1, 0)), #right
			(player_tile_pos + Vector2i(-1, 1)), #bottom left
			(player_tile_pos + Vector2i(0, 1)), #bottom
			(player_tile_pos + Vector2i(1, 1)), #bottom right
		]
	for cell in surrounding_cells:
		if dirt.get_cell_tile_data(cell):
			nearby_tiles.append(cell)
	
	return nearby_tiles

func is_valid_tile(target_tile):
	if target_tile in get_nearby_tiles():
		return true
	else:
		return false

func add_treasure(treasure_type):
	match treasure_type:
		"copper":
			money += 1
		"silver":
			money += 2
		"gold":
			money += 3
		"emerald":
			money += 4
		"ruby":
			money += 5
		"diamond":
			money += 10
	money_gui.set_money_label(money)


func _on_treasure_chest_collected() -> void:
	money += 10
	money_gui.set_money_label(money)
