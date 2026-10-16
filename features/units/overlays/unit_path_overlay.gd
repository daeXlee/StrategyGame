extends Node2D

@onready var game_map := %GameTileMapLayer
@onready var unit_manager := %UnitManager

var selected_unit: Unit = null
var destination_tile: Vector2i = Vector2i(-9999, -9999)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.hovering_changed.connect(_on_hovering_changed)
	EventBus.unit_selection_changed.connect(_on_unit_selection_changed)
	EventBus.unit_moved.connect(_on_unit_moved)


func _draw() -> void:
	if !selected_unit:
		return
	
	var movement_result: MovementResult = unit_manager.calculate_move(selected_unit, destination_tile)
	
	# TODO: Differentiate reachable, unreachable path, if invalid
	
	if !movement_result.valid:
		return
	print(movement_result.reachable_path.size(), " ", movement_result.remaining_path.size())
	if movement_result.reachable_path.size() > 1:
		draw_polyline(movement_result.reachable_path, Color.BLUE, 5)
	if movement_result.remaining_path.size() > 1:
		draw_polyline(movement_result.remaining_path, Color.RED, 5)


func _on_unit_selection_changed(unit: Unit) -> void:
	selected_unit = unit
	queue_redraw()


func _on_hovering_changed(coord: Vector2i) -> void:
	destination_tile = coord
	queue_redraw()


func _on_unit_moved(_unit: Unit, _from_coord: Vector2i, _to_coord: Vector2i) -> void:
	queue_redraw()
 
