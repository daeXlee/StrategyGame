class_name WorldGenerationSetting
extends RefCounted


var width: int = 0
var height: int = 0
# TODO Other parameters for world generation


func _init(grid_width: int = 15, grid_height: int = 10) -> void:
	width = grid_width
	height = grid_width
