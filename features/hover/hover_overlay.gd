extends Node2D

@onready var game_map := %GameTileMapLayer

var hovered_coord := Vector2i(-9999, -9999)


func _ready() -> void:
	EventBus.hovering_changed.connect(_on_hovering_changed);


func _draw() -> void:
	if game_map.get_cell_source_id(hovered_coord) == -1:
		return
	var cube_coords: Array[Vector3i] = [game_map.map_to_cube(hovered_coord)]
	var outlines = game_map.cube_outlines(cube_coords)
	var points = outlines[0]
	points.append(points[0])
	
	draw_polyline(points, Color.YELLOW, 2)


func _on_hovering_changed(coord: Vector2i) -> void:
	hovered_coord = coord
	queue_redraw()
