extends Node2D

@onready var game_map: HexagonTileMapLayer = %GameTileMapLayer
@onready var selection_overlay: HexagonTileMapLayer = %SelectionTileMapLayer
@onready var world_manager: WorldManager = $WorldManager
@onready var unit_manager: UnitManager = $UnitManager
@onready var unit_hud: UnitHUD = %UnitHUD

@export var grid_width := 15
@export var grid_height := 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.world_loaded.connect(_render_world)
	EventBus.tile_selected.connect(_on_tile_selected)
	EventBus.tile_deselected.connect(_on_tile_deselected)
	EventBus.turn_started.connect(_on_turn_started)
	unit_hud.unit_delete.connect(_on_unit_delete)
	_initialize_world()
	
	# TODO: For Testing remove later
	GameManager.start_game()
	_create_test_unit()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var tile_under_mouse = game_map.local_to_map(get_local_mouse_position())
		world_manager.hover_tile(tile_under_mouse)
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			_handle_left_click(get_local_mouse_position())


func _initialize_world() -> void:
	# TODO: Load World Data from Save or from new world settings
	var settings := WorldGenerationSetting.new(grid_width, grid_height)
	var map_data := WorldGenerator.generate(settings)
	
	world_manager.set_world(map_data)


func _render_world() -> void:
	if !world_manager.map:
		push_error("Cannot Render World: Map Data is null")
		return
	
	for coord in world_manager.map.tiles:
		game_map.set_cell(coord, 0, Vector2i(0,0))
	game_map.pathfinding_generate_points()


func _handle_left_click(mouse_pos: Vector2) -> void:
	var coord := game_map.local_to_map(mouse_pos)
	world_manager.select_tile(coord)
	
	var unit := unit_manager.get_unit_at(coord)
	if unit:
		world_manager.select_unit(unit)
	else:
		if world_manager.selected_unit:
			unit_manager.move_unit(world_manager.selected_unit, coord)
			return
		
		world_manager.select_unit(null)


func _on_tile_selected(coord: Vector2i) -> void:
	selection_overlay.clear()
	selection_overlay.set_cell(coord, 0, Vector2i(0,0))


func _on_tile_deselected() -> void:
	selection_overlay.clear()

# TODO: Temp Initializer for Units
func _create_test_unit() -> void:
	var data := UnitData.new("Scout", 2, 100)
	
	var initial_spawn = Vector2i(7, 7)
	var position = game_map.map_to_local(initial_spawn)
	unit_manager.spawn_unit(data, position, initial_spawn)


func _on_unit_delete() -> void:
	if world_manager.selected_unit:
		unit_manager.delete_unit(world_manager.selected_unit)
		world_manager.select_unit(null)
	else:
		print("No Unit Selected")


func _on_turn_started() -> void:
	selection_overlay.clear()
