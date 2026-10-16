extends Control
class_name UnitHUD

@onready var move_button = $HBoxContainer/MoveButton
@onready var delete_button = $HBoxContainer/DeleteButton

signal unit_delete
signal unit_move

var move_action_selected := false

func _ready() -> void:
	EventBus.unit_selection_changed.connect(_on_unit_selection_changed)
	hide()


func _on_unit_selection_changed(unit: Unit) -> void:
	move_action_selected = false
	if unit:
		show()
	else:
		hide()


func _on_delete_button_pressed() -> void:
	unit_delete.emit()


func _on_move_button_pressed() -> void:
	pass # Replace with function body.
