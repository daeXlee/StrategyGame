extends HexagonTileMapLayer

@export var current_tile: Vector3i = Vector3i.ZERO
var path_line: Line2D
var outline_line: Line2D
signal tile_updated

func _init() -> void:
	path_line = Line2D.new()
	path_line.width = 10.0
	path_line.default_color = Color.BLUE
	path_line.z_index = 100
	add_child(path_line)
	
	outline_line = Line2D.new()
	outline_line.width = 4
	outline_line.default_color = Color.YELLOW
	outline_line.closed = true
	add_child(outline_line)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()	
	

	# Create an outline for a group of cells
	#var center = Vector3i(0,0,0)
	#var cellRing = cube_ring(center, 0)
	#var outlines =  cube_outlines(cellRing)
	#print(outlines)  # Output: [[[x1,y1], [x2,y2], ...]] - Array of point arrays
	### Visualize the outline with a Line2D
	### Each outline is a separate closed polygon
	#for outline in outlines:
		#var line = Line2D.new()
		#line.width = 4
		#line.default_color = Color.BLACK
		#line.closed = true
		#for point in outline:
			#line.add_point(point)
		#line.add_point(outline[0])  # Close the polygon
		#add_child(line)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent):
	if is_visible_in_tree() and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var cell_under_mouse = get_closest_cell_from_mouse()
		var is_tile_ocean = get_cell_tile_data(cube_to_map(cell_under_mouse)).get_custom_data("is_ocean")
		
		if (is_tile_ocean == true):
			return
			
		draw_outline(cell_under_mouse)
		if cell_under_mouse.distance_squared_to(current_tile) != 0:
			draw_path(cell_under_mouse)
			current_tile = cell_under_mouse
			tile_updated.emit()

# Override Path Finding Functions
func _pathfinding_does_tile_connect(tile: Vector2i, neighbor: Vector2i) -> bool:
	var is_tile_ocean = get_cell_tile_data(tile).get_custom_data("is_ocean")
	var is_neighbor_ocean = get_cell_tile_data(neighbor).get_custom_data("is_ocean")
	return is_tile_ocean == is_neighbor_ocean
	
	
# Override Path Finding Functions
func _pathfinding_get_tile_weight(coords: Vector2i) -> float:
	return get_cell_tile_data(coords).get_custom_data("pathfinding_weight")


func draw_outline(tile: Vector3i) -> void:
	outline_line.clear_points()
	var cell_ring = cube_ring(tile, 0)
	var outlines = cube_outlines(cell_ring)
	
	for outline in outlines:
		for point in outline:
			outline_line.add_point(point)		

func draw_path(destination_tile: Vector3i) -> void:
	path_line.clear_points()
	var from = pathfinding_get_point_id(cube_to_map(current_tile))
	var target = pathfinding_get_point_id(cube_to_map(destination_tile))
	var path = astar.get_id_path(from, target)
	var points: Array[Vector3i] = []
	for point_id in path:
		var point_pos = astar.get_point_position(point_id)
		path_line.add_point(point_pos)
