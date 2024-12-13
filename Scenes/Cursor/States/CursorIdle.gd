class_name CursorIdle extends State

func unhandled_input(event: InputEvent) -> void:
	actor = actor as Cursor
	if event.is_action_pressed("left_click"):
		var entity: Entity = actor.get_entity_under_mouse()
		if not entity:
			return
		if entity.faction == actor.faction:
			actor.selected = entity
			Event.cursor_selected.emit(entity)
			transition.emit("CursorSelected")
	if event.is_action_pressed("right_click"):
		var entity: Entity = actor.get_entity_under_mouse()
		if entity:
			if entity.faction != actor.faction:
				pass # TODO Inspect Entity
