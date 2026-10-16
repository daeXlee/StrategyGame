class_name HexTileData
extends RefCounted


var coord: Vector2i = Vector2i.ZERO


func _init(tile_coord: Vector2i = Vector2i.ZERO) -> void:
	coord = tile_coord
