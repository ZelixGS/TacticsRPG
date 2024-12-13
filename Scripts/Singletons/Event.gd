extends Node

@warning_ignore("unused_signal")
signal cursor_selected(entity: Entity)
@warning_ignore("unused_signal")
signal cursor_deselected()
@warning_ignore("unused_signal")
signal cursor_request_entities()
@warning_ignore("unused_signal")
signal cursor_request_cell()
@warning_ignore("unused_signal")
signal cursor_complete_entities()
@warning_ignore("unused_signal")
signal cursor_complete_cell(cell: Vector2i)
@warning_ignore("unused_signal")
signal cursor_cancel()


@warning_ignore("unused_signal")
signal highlight_clear_all()
@warning_ignore("unused_signal")
signal highlight_movement(cells: Array[Vector2i])
@warning_ignore("unused_signal")
signal highlight_attack(cells: Array[Vector2i])
@warning_ignore("unused_signal")
signal highlight_path(cells: Array[Vector2i])
@warning_ignore("unused_signal")
signal highlight_aoe(cells: Array[Vector2i])

@warning_ignore("unused_signal")
signal select_entity(mouse_postion: Vector2, entity: Entity)

@warning_ignore("unused_signal")
signal player_selected_entity(entity: Entity)
@warning_ignore("unused_signal")
signal player_deselected_entity()


@warning_ignore("unused_signal")
signal entity_undo_movement(entity: Entity)

@warning_ignore("unused_signal")
signal mouse_over_new_cell(cell: Vector2i)

@warning_ignore("unused_signal")
signal spell_stop_targeting()

@warning_ignore("unused_signal")
signal debug_add_apple(amount: int)


@warning_ignore("unused_signal")
signal ui_mouseover_hud(entity: Entity)
#func _ready() -> void:
	#cursor_selected.connect(test)
#
#func test(entity: Entity) -> void:
	#print("Signal Recieved")
