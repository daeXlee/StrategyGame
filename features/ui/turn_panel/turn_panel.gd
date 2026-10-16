extends MarginContainer

@onready var turn_label = $PanelContainer/MarginContainer/VBoxContainer/TurnLabel
@onready var next_turn_button = $PanelContainer/MarginContainer/VBoxContainer/NextTurnButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.turn_started.connect(_on_turn_started)
	next_turn_button.pressed.connect(_on_next_turn_pressed)
	_set_initial()

func _set_initial() -> void:
	# TODO: whatever other turn panel ui
	turn_label.text = "Turn %d" % GameManager.current_turn


func _on_turn_started() -> void:
	turn_label.text = "Turn %d" % GameManager.current_turn


func _on_next_turn_pressed() -> void:
	GameManager.end_turn()
