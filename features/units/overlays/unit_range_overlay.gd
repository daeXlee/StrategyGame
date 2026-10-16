extends Node2D

@onready var game_map := %GameTileMapLayer

var selected_unit: Unit = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.unit_selection_changed.connect(_on_unit_selection_changed)
	EventBus.unit_moved.connect(_on_unit_moved)


func _draw() -> void:
	if !selected_unit:
		return
	var cube_coord = game_map.map_to_cube(selected_unit.tile_coord)
	var outline_tiles = game_map.cube_ring(cube_coord, selected_unit.data.max_movement_points)
	var outlines = game_map.cube_outlines(outline_tiles)
	
	var points = outlines[0]
	points.append(points[0])  # Close Polygon
	draw_polyline(points, Color.PINK, 2)


func _on_unit_selection_changed(unit: Unit) -> void:
	selected_unit = unit
	queue_redraw()


func _on_unit_moved(_unit: Unit, _from_coord: Vector2i, _to_coord: Vector2i) -> void:
	queue_redraw()
