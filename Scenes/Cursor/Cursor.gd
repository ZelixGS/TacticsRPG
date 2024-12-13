class_name Cursor extends Node2D

@export var faction: Enum.FACTION = Enum.FACTION.PLAYER

@export_category("Internals")
@export var sprite_2d: Sprite2D

var selected: Entity
var spell: Spell

var previous_cell: Vector2i = Vector2i(0, 0)

#region Ready & Process

func _process(_delta: float) -> void:
	Debug.add_property("Cursor Selected", selected, 1)
	Debug.add_property("Cursor Spell", spell, 2)
	update_cursor()

func update_cursor() -> void:
	var current_cell: Vector2i = Grid.world_to_cell(get_global_mouse_position())
	global_position = Grid.cell_to_world(current_cell)
	if current_cell != previous_cell:
		previous_cell = current_cell
		Event.mouse_over_new_cell.emit(current_cell)

#endregion

func get_entity_under_mouse() -> Entity:
	var space_state: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	var parameters: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	parameters.position = global_position
	parameters.collision_mask = 2 # Entity Only
	var result: Array[Dictionary] = space_state.intersect_point(parameters)
	if result.size() > 0:
		return result[0]["collider"] as Entity
	return null

#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("left_click"):
		#match state:
			#STATE.NONE:
				#state_none()
			## STATE.SELECTED:
			## 	state_selected()
			#STATE.TARGETING:
				#state_targeting()
	#if event.is_action_pressed("right_click"):
		#match state:
			#STATE.NONE:
				#return
			#STATE.SELECTED:
				#deselect_entity()

# func state_selected() -> void:
# 	if grid.mouse_cell() in grid.get_movement_cells(selected):
# 		grid.request_move(selected, grid.mouse_cell())

func state_targeting() -> void:
	if spell:
		var entity: Entity = get_entity_under_mouse()
		if entity:
			spell.add_target(entity)
