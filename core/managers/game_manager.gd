extends Node

# GLOBAL STATE VARIABLES
var current_turn: int = 1
var current_player_index: int = 0
# var players: Array[PlayerData]


func start_game() -> void:
	# TODO: Load Game Data, Player Info, World Info
	begin_turn()


func end_turn() -> void:
	print("End Turn Processing")
	current_turn += 1
	begin_turn()


func begin_turn() -> void:
	print("Starting Turn")
	EventBus.turn_started.emit()


func next_player() -> void:
	pass
