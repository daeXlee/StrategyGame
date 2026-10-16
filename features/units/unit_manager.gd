class_name UnitManager
extends Node

@onready var game_map: HexagonTileMapLayer = %GameTileMapLayer
@export var unit_scene: PackedScene

var units: Array[Unit] = []


func _ready() -> void:
	EventBus.turn_started.connect(_on_turn_started)


func spawn_unit(data: UnitData, position: Vector2, tile_coord: Vector2i) -> Unit:
	var unit := unit_scene.instantiate() as Unit
	add_child(unit)
	unit.position = position
	unit.initialize(data, tile_coord)
	units.append(unit)
	return unit;


func get_unit_at(coord: Vector2i) -> Unit:
	for unit in units:
		if unit.tile_coord == coord:
			return unit
	
	return null


func delete_unit(unit: Unit) -> void:
	if !units.has(unit):
		print("Unit does not exist")
		return
	units.erase(unit)
	unit.queue_free()


func calculate_move(unit: Unit, destination: Vector2i) -> MovementResult:
	var result := MovementResult.new()
	
	if not _can_unit_move(unit):
		print("No movement points left")
		result.valid = false
		return result
	
	if not _is_destination_valid(destination):
		print("Destination invalid")
		result.valid = false
		return result
	
	# TODO: Get Path, Calculate P ath Cost, Check Movement Cost
	var path := _get_path(unit, destination)
	result.path = path
	result.valid = true
	
	# TODO: get the cost, split path -> reachable, remaining
	_calculate_path_movement_costs(unit.data.movement_points, result)
	
	return result


func move_unit(selected_unit: Unit, destination: Vector2i) -> void:
	var result := calculate_move(selected_unit, destination)
	
	if not result.valid:
		return

	_execute_movement(selected_unit, result.reachable_path, result.total_cost)

func _can_unit_move(unit: Unit) -> bool:
	return unit.data.movement_points > 0


func _is_destination_valid(destination: Vector2i) -> bool:
	if game_map.get_cell_source_id(destination) == -1:
		return false
	
	if get_unit_at(destination) != null:
		return false

	return true


func _get_path(unit: Unit, destination: Vector2i) -> Array[Vector2]:
	var start_point = game_map.pathfinding_get_point_id(unit.tile_coord)
	var end_point = game_map.pathfinding_get_point_id(destination)
	var path = game_map.astar.get_id_path(start_point, end_point)
	var coords: Array[Vector2] = []
	for point_id in path:
		var point_pos = game_map.astar.get_point_position(point_id)
		coords.append(point_pos)
	
	return coords


func _calculate_path_movement_costs(available_movement: int, result: MovementResult) -> void:
	var remaining_movement: float = available_movement
	result.reachable_path.append(result.path[0])
	for i in range(1, result.path.size()):
		var tile_coord := game_map.local_to_map(result.path[i])
		var tile_cost := game_map._pathfinding_get_tile_weight(tile_coord)
		
		if remaining_movement >= tile_cost:
			result.reachable_path.append(result.path[i])
			result.total_cost += tile_cost
			remaining_movement -= tile_cost
			if remaining_movement <= 0:  # Add starting point of unreachable path
				result.remaining_path.append(result.path[i])
		else:
			result.remaining_path.append(result.path[i])


func _execute_movement(unit: Unit, path: Array[Vector2], movement_cost: int) -> void:
	var from_coord := unit.tile_coord
	unit.data.movement_points -= movement_cost
	
	var to_coord := path[-1]
	var map_position := game_map.local_to_map(to_coord)
	unit.set_tile(map_position, to_coord)
	
	EventBus.unit_moved.emit(unit, from_coord, map_position)


func _on_turn_started() -> void:
	for unit in units:
		unit.data.reset_movement_points()
