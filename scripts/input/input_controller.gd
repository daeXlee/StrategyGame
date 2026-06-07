extends Node2D

@export var selection_system: SelectionSystem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_pos = get_local_mouse_position()
		selection_system.handle_hover(mouse_pos)
	
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_pos = get_local_mouse_position()
			selection_system.handle_select(mouse_pos)
