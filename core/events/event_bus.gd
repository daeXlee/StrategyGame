extends Node


signal world_loaded()
signal turn_started()

signal hovering_changed(coord: Vector2i)
signal tile_selected(coord: Vector2i)
signal tile_deselected()

signal unit_selection_changed(unit: Unit)
signal unit_moved(unit: Unit, from_coord: Vector2i, to_coord: Vector2i)
