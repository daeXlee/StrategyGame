extends Node
class_name MovementSystem

@export var grid_system: GridSystem

func get_unit_movement_range(coords: Vector3i) -> void:
	pass # Do
	
	
func move_unit(unit: UnitBase, coords: Vector3i) -> void:
	if not can_move_to(coords):
		return
	
	grid_system.move_unit(unit, coords)
	

func can_move_to(coords: Vector3i) -> bool:
	# If tile is occupied return false
	return true
