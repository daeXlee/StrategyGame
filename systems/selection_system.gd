extends Node
class_name SelectionSystem

@export var grid_system: GridSystem
@export var movement_system: MovementSystem

signal tile_hovered(cube_coord: Vector3i)
signal tile_clicked(cub_coord: Vector3i)
signal draw_path(to_coord: Vector3i)

var selected_unit: UnitBase

func handle_hover(local_coord: Vector2) -> void:
	var map_coord = grid_system.get_map_coords_from_local(local_coord)
	tile_hovered.emit(map_coord)
	
	if selected_unit:
		draw_path.emit(map_coord)


func handle_select(local_coord: Vector2) -> void:
	var map_coord = grid_system.get_map_coords_from_local(local_coord)
	tile_clicked.emit(map_coord)
	
	var cube_coord = grid_system.get_cube_coords_from_local(local_coord)
	var clicked_unit = grid_system.get_unit_at(cube_coord)
	
	if clicked_unit:
		if selected_unit:
			unselect_unit()
		else:
			select_unit(clicked_unit)
	elif selected_unit:
		movement_system.move_unit(selected_unit, cube_coord)
		#unselect_unit()  # TODO: Determine if after action should select follow
	
	print(selected_unit)


func select_unit(unit: UnitBase) -> void:
	selected_unit = unit


func unselect_unit() -> void:
	if selected_unit:
		selected_unit = null
