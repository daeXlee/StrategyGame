class_name HexMapData
extends RefCounted

var width: int = 0
var height: int = 0
var tiles: Dictionary[Vector2i, HexTileData] = {}


func _init(grid_width: int = 15, grid_height: int = 10) -> void:
	if grid_width <= 0 or grid_height <= 0:
		push_error("HexGrid: invalid dimensions (%d x %d)" % [grid_width, grid_height])
	
	width = grid_width
	height = grid_height
	
	_initialize_tiles()


func _initialize_tiles() -> void:
	tiles.clear()
	for y in height:
		for x in width:
			var coord := Vector2i(x, y)
			tiles[coord] = HexTileData.new(coord)
