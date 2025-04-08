extends TileMapLayer

func is_origin(coordinates):
	if get_cell_tile_data(coordinates + Vector2i(0, 1)) or get_cell_tile_data(coordinates + Vector2i(0, -1)):
		return false
	else:
		return true

func get_neighbor_tiles(coordinates):
	var upper_cell = get_cell_tile_data(coordinates + Vector2i(0, -1))
	var lower_cell = get_cell_tile_data(coordinates + Vector2i(0, 1))
	
	var neighbors = []
	if upper_cell:
		neighbors.append(upper_cell)
	else:
		neighbors.append(null)
	if lower_cell:
		neighbors.append(lower_cell)
	else:
		neighbors.append(null)
		
	return neighbors

func set_ladder(coordinates):
	set_cell(coordinates, 0, Vector2i(0, 0))
