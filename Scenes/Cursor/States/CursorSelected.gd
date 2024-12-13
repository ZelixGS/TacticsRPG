class_name CursorSelected extends State

func enter() -> void:
	Event.cursor_request_entities.connect(enter_casting, CONNECT_ONE_SHOT)

func unhandled_input(event: InputEvent) -> void:
	actor = actor as Cursor
	if event.is_action_pressed("left_click"):
		pass
	if event.is_action_pressed("right_click"):
		pass

func enter_casting(spell: Spell) -> void:
	actor.spell = spell
	transition.emit("CursorCasting")
