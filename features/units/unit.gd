class_name Unit
extends Node2D


var data: UnitData
var tile_coord: Vector2i


func _ready() -> void:
	EventBus.unit_selection_changed.connect(_on_unit_selection_changed)
	EventBus.unit_moved.connect(_on_unit_moved)


func initialize(unit_data: UnitData, coord: Vector2i) -> void:
	data = unit_data
	tile_coord = coord
	$SelectionIndicator.visible = false


func set_tile(coord: Vector2i, local_position: Vector2) -> void:
	tile_coord = coord
	position = local_position


func _on_unit_selection_changed(selected_unit: Unit) -> void:
	$SelectionIndicator.visible = selected_unit == self


func _on_unit_moved(unit: Unit, from_coord: Vector2i, to_coord: Vector2i) -> void:
	pass
	#if unit == self:
		#data.reset_movement_points()
