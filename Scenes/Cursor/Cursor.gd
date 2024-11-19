class_name Cursor extends Node2D

enum STATE { NONE, SELECTED, MEASURE }

@export var faction: Entity.FACTION
@export var label: Label

var game_board: GameBoard

var current_state: STATE = STATE.NONE
var current_selection: Entity
var movement_cells: Array[Vector2i]

func _ready() -> void:
	game_board = Global.game_board

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		match current_state:
			STATE.NONE:
				var entity: Entity = game_board.get_mouse_entity()
				if is_in_my_faction(entity):
					select_entity(entity)
				else:
					print("The Enemy!")
			STATE.SELECTED:
				if not current_selection:
					return
				var new_entity: Entity = game_board.get_mouse_entity()
				if is_in_my_faction(new_entity):
					deselect_entity()
					select_entity(new_entity)
				else:
					if game_board.mouse_cell() in game_board.get_movement_cells(current_selection):
						game_board.request_move(current_selection, game_board.mouse_cell())
					else:
						deselect_entity()

func _process(_delta: float) -> void:
	Debug.add_property("Cursor State", current_state)
	Debug.add_property("Currrently Selected", current_selection)
	global_position = game_board.mouse_cell_to_pixel()

func select_entity(entity: Entity) -> void:
	current_state = STATE.SELECTED
	current_selection = entity
	Event.selected_entity.emit(current_selection)

func deselect_entity() -> void:
	current_state = STATE.NONE
	current_selection = null
	Event.deselected_entity.emit()

func is_in_my_faction(entity: Entity) -> bool:
	if entity:
		if entity.faction == faction:
			return true
	return false

func get_distance(a: Vector2i, b: Vector2i) -> float:
	return (abs(a.x - b.x) + abs(a.y - b.y)) / 16
