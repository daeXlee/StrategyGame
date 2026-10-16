extends Node
class_name WorldManager


var map: HexMapData
var hovering_tile: Vector2i = Vector2i(-9999, -9999)
var selected_tile: HexTileData = null
var selected_unit: Unit = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.turn_started.connect(_on_turn_started)
	EventBus.unit_moved.connect(_on_unit_moved)

func set_world(map_data: HexMapData) -> void:
	map = map_data
	selected_tile = null
	selected_unit = null
	# TODO: other state initialization
	
	EventBus.world_loaded.emit()


func hover_tile(coord: Vector2i) -> void:
	if coord.distance_squared_to(hovering_tile) != 0:
		hovering_tile = coord
		EventBus.hovering_changed.emit(coord)


func select_tile(coord: Vector2i) -> void:
	if map.tiles.has(coord):
		var tile = map.tiles[coord]

		if selected_tile == tile:
			selected_tile = null
			EventBus.tile_deselected.emit()
		else:
			selected_tile = tile
			EventBus.tile_selected.emit(selected_tile.coord)


func select_unit(unit: Unit) -> void:
	if selected_unit == unit:
		selected_unit = null
	else:
		selected_unit = unit
	
	EventBus.unit_selection_changed.emit(selected_unit)


func _on_turn_started() -> void:
	select_unit(null)
	selected_tile = null


func _on_unit_moved(unit: Unit, from_coord: Vector2i, to_coord: Vector2i) -> void:
	select_tile(to_coord)
