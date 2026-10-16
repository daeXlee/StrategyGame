extends HexagonTileMapLayer


func _pathfinding_get_tile_weight(coords: Vector2i) -> float:
	return get_cell_tile_data(coords).get_custom_data("move_weight")
