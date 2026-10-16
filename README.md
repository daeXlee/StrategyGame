Strategy Game

Project File Structure:
	GridManager:
		Map Coordinates, Tile Lookups, Neighbor Calc, PathFinding, Tile Occupancy, "Data Access Layer Tiles"
	UnitManager:
		Tracks All Units, Add/Delete Units, Find Units, "Data Access Layer for Units"
	InputSystem:
		Handles User Inputs, Sends Signals for other systems to consume, "Controller"
	SelectionSystem:
		Owns transient UI/Gameplay intent state
	MovementSystem:
		Handles Movement Logic, Detemines Range, "Service/Application Layer"
	CombatSystem:
		Handles Attack Range, Damage Calculation, Death Handling, "Serivce/Application Layer"
	Scenes:
		Visual Object Representation, Should not contain Game Logic
	Data Objects:
		Data Model
