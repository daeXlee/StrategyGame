class_name UnitData
extends Resource

@export var unit_name: String = ""
@export var max_movement_points: int = 2
@export var max_health: int = 100

var movement_points: int
var health_points: int

func _init(name: String = "", movement: int = 2, health: int = 100) -> void:
	unit_name = name
	max_movement_points = movement
	max_health = health
	
	movement_points = movement
	health_points = max_health


func reset_movement_points() -> void:
	movement_points = max_movement_points
