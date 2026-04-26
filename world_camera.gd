extends Camera2D

@export var speed = 500
@export var zoom_speed = 0.1
@export var min_zoom = 0.5
@export var max_zoom = 3.0

var zoom_target = zoom

func _process(delta):
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += dir * speed * delta

	if Input.is_action_just_pressed("zoom_in"):
		zoom_target += Vector2(0.2, 0.2)

	if Input.is_action_just_pressed("zoom_out"):
		zoom_target -= Vector2(0.2, 0.2)

	zoom_target.x = clamp(zoom_target.x, min_zoom, max_zoom)
	zoom_target.y = clamp(zoom_target.y, min_zoom, max_zoom)

	zoom = zoom.lerp(zoom_target, 0.1)
