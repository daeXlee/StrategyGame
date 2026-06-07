extends Node
class_name GridSystem

@export var map: HexagonTileMapLayer

var units := {}  # Hashmap of all units in map. Key: Unit Coord, Value: UnitBase


func get_cube_coords_from_local(local_coord: Vector2) -> Vector3i:
	return map.local_to_cube(local_coord)

func get_map_coords_from_local(local_coord: Vector2) -> Vector2i:
	return map.local_to_map(local_coord)


func register_unit(unit: UnitBase) -> void:
	units[unit.grid_coords] = unit


func get_unit_at(coords: Vector3i) -> UnitBase:
	return units.get(coords)
	
	
func move_unit(unit: UnitBase, new_coords: Vector3i) -> void:
	print("Unit moved", unit.grid_coords, "->", new_coords)
	units.erase(unit.grid_coords)
	unit.grid_coords = new_coords
	unit.position = map.cube_to_local(new_coords)
	units[new_coords] = unit
