extends TileMapLayer

@onready var earth = $Earth

func update_range_highlight(nearby_tiles):
	for tile in nearby_tiles:
		set_cell(tile, 0, Vector2i(1, 0))
		

func set_target_tile(target_tile):
	set_cell(target_tile, 0, Vector2(0, 0))
