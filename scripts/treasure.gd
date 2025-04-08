extends TileMapLayer

func has_treasure(coordinates):
	if get_cell_tile_data(coordinates):
		return true
	else:
		return false

func remove_treasure(coordinates):
	erase_cell(coordinates)

func get_treasure_type_at_pos(tile_coordinates):
	match get_cell_atlas_coords(tile_coordinates):
		Vector2i(0, 0):
			return "copper"
		Vector2i(1, 0):
			return "silver"
		Vector2i(0, 1):
			return "gold"
		Vector2i(1, 1):
			return "diamond"
		Vector2i(2, 0):
			return "emerald"
		Vector2i(2, 1):
			return "ruby"
