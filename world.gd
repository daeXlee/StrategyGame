extends Node2D

@onready var tile_map = $TileMapLayer
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_tile_map_layer_tile_updated() -> void:
	move_character_to_mouse()

func move_character_to_mouse() -> void:
		var local_coord = tile_map.cube_to_local(tile_map.current_tile)
		print(local_coord)
		
		player.global_position = local_coord
		
