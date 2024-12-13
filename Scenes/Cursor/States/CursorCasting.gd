class_name CursorCasting extends State

func enter() -> void:
	Event.spell_stop_targeting.connect(leave_casting, CONNECT_ONE_SHOT)

func exit() -> void:
	actor.spell = null

func update(_delta: float) -> void:
	if actor.spell:
		Debug.add_property("Spell Targets", actor.spell.targets, 3)

func unhandled_input(event: InputEvent) -> void:
	actor = actor as Cursor
	if event.is_action_pressed("left_click"):
		var entity: Entity = actor.get_entity_under_mouse()
		if not entity:
			return
		actor.spell.add_target(entity)
	if event.is_action_pressed("right_click"):
		actor.spell.remove_target()

func leave_casting() -> void:
	transition.emit("CursorSelected")
