extends Node
class_name HighlightSystem

@export var hover_layer: HexagonTileMapLayer
@export var selection_layer: HexagonTileMapLayer
@export var range_layer: HexagonTileMapLayer

const HOVER_TILE = 0
const SELECT_TILE = 0
# TODO: Add other types, could move to enums

var current_hovered_tile: Vector2i
var current_selected_tile:= Vector2i(-9999, -9999)
var movement_path_line: Line2D

func _init() -> void:
	movement_path_line = Line2D.new()
	movement_path_line.width = 10.0
	movement_path_line.default_color = Color.BLUE
	movement_path_line.z_index = 5
	#range_layer.add_child(movement_path_line)

func _ready() -> void:
	pass

func _on_selection_system_tile_hovered(map_coord: Vector2i) -> void:
	show_hover(map_coord)


func _on_selection_system_tile_clicked(map_coord: Vector2i) -> void:
	if map_coord == current_selected_tile:
		clear_selected()
	else:
		show_selected(map_coord)
	

func _on_selection_system_draw_path(to_coord: Vector2i) -> void:
	if current_selected_tile == Vector2i(-9999, -9999) or current_selected_tile == to_coord:
		return
	
	
	

func show_hover(coords: Vector2i) -> void:
	if current_hovered_tile == coords:
		return
	
	clear_hover()
	current_hovered_tile = coords
	hover_layer.set_cell(coords, HOVER_TILE, Vector2i(0,0))
	

func clear_hover() -> void:
	hover_layer.erase_cell(current_hovered_tile)


func show_selected(coords: Vector2i) -> void:
	clear_selected()
	current_selected_tile = coords
	selection_layer.set_cell(coords, SELECT_TILE, Vector2i(0,0))


func clear_selected() -> void:
	selection_layer.erase_cell(current_selected_tile)
	current_selected_tile = Vector2i(-9999, -9999)


func draw_movement_path(destination_tile: Vector3i) -> void:
	movement_path_line.clear_points()
