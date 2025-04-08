extends TileMapLayer

var atlas_lookup_dict = {
	"top-left": Vector2i(0, 0),
	"top": Vector2i(1, 0),
	"top-right": Vector2i(2, 0),
	"left": Vector2i(0, 1),
	"middle": Vector2i(1, 1),
	"right": Vector2i(2, 1),
	"bottom-left": Vector2i(0, 2),
	"bottom": Vector2i(1, 2),
	"bottom-right": Vector2i(2, 2),
	"single": Vector2i(0, 3),
	"ledge-left": Vector2i(1, 3),
	"ledge-middle": Vector2i(2, 3),
	"ledge-right": Vector2i(3, 3),
	"column-top": Vector2i(3, 0),
	"column-middle": Vector2i(3, 1),
	"column-bottom": Vector2i(3, 2)
}

func update_neighbor_tiles(selected_tile):
	var neighbor_tiles = get_neighbor_tiles(selected_tile)
	for tile in neighbor_tiles:
		var tile_code = []
		for cell in get_surrounding_cells(tile):
			if get_cell_tile_data(cell):
				tile_code.append(1)
			else:
				tile_code.append(0)
			match tile_code:
				[0, 0, 0, 0]:
					set_cell(tile, 0, atlas_lookup_dict["single"])
					break
				[1, 1, 1, 1]:
					set_cell(tile, 0, atlas_lookup_dict["middle"])
					break
				[1, 1, 1, 0]:
					set_cell(tile, 0, atlas_lookup_dict["top"])
					break
				[1, 0, 1, 1]:
					set_cell(tile, 0, atlas_lookup_dict["bottom"])
					break
				[0, 1, 1, 1]:
					set_cell(tile, 0, atlas_lookup_dict["right"])
					break
				[1, 1, 0, 1]:
					set_cell(tile, 0, atlas_lookup_dict["left"])
					break
				[1, 1, 0, 0]:
					set_cell(tile, 0, atlas_lookup_dict["top-left"])
					break
				[0, 1, 1, 0]:
					set_cell(tile, 0, atlas_lookup_dict["top-right"])
					break
				[0, 0, 1, 1]:
					set_cell(tile, 0, atlas_lookup_dict["bottom-right"])
					break
				[1, 0, 0, 1]:
					set_cell(tile, 0, atlas_lookup_dict["bottom-left"])
					break
				[1, 0, 0, 0]:
					set_cell(tile, 0, atlas_lookup_dict["ledge-left"])
					break
				[1, 0, 1, 0]:
					set_cell(tile, 0, atlas_lookup_dict["ledge-middle"])
					break
				[0, 0, 1, 0]:
					set_cell(tile, 0, atlas_lookup_dict["ledge-right"])
					break
				[0, 1, 0, 0]:
					set_cell(tile, 0, atlas_lookup_dict["column-top"])
					break
				[0, 1, 0, 1]:
					set_cell(tile, 0, atlas_lookup_dict["column-middle"])
					break
				[0, 0, 0, 1]:
					set_cell(tile, 0, atlas_lookup_dict["column-bottom"])
					break
		

func get_neighbor_tiles(center_cell):
	var neighbor_tiles = []
	var neighbor_cells = get_neighbor_cells(center_cell)
	for cell in neighbor_cells:
		if get_cell_tile_data(cell):
			neighbor_tiles.append(cell)
	return neighbor_tiles

func get_neighbor_cells(center_cell):
		var neighbor_cells = [
			(center_cell + Vector2i(1, 0)), #right
			(center_cell + Vector2i(1, 1)), #bottom right
			(center_cell + Vector2i(0, 1)), #bottom
			(center_cell + Vector2i(-1, 1)), #bottom left
			(center_cell + Vector2i(-1, 0)), #left
			(center_cell + Vector2i(-1, -1)), #top left
			(center_cell + Vector2i(0, -1)), #top
			(center_cell + Vector2i(1, -1)), #top right
		]
		return neighbor_cells
