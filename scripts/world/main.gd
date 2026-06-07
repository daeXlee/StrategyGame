extends Node2D

@export var grid_system: GridSystem
@export var terrain_Layer: HexagonTileMapLayer
@export var unit_container: Node2D

var unit_scene = preload("res://scenes/unit_base.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_unit(Vector3i(0, 0, 0))


func spawn_unit(coords: Vector3i) -> void:
	var unit = unit_scene.instantiate()
	unit.grid_coords = coords
	unit.position = terrain_Layer.cube_to_local(coords)
	unit_container.add_child(unit)
	grid_system.register_unit(unit)
