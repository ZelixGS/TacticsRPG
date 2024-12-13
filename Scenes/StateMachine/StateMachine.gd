class_name StateMachine extends Node

@export var default_state: State
@export var actor: Node2D

var current_state: State
var previous_state: State

var states: Dictionary = {}

func _ready() -> void:
	for child: Node in get_children():
		if child is State:
			states[child.name] = child
			@warning_ignore("unsafe_property_access", "unsafe_method_access")
			child.transition.connect(on_state_transition)
		else:
			push_warning("State Machine contains incompatible child node.")
	current_state = default_state

func _process(delta: float) -> void:
	current_state.update(delta)
	Debug.add_property("State", current_state.name, 1)

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)

func _unhandled_input(event: InputEvent) -> void:
	current_state.unhandled_input(event)

func on_state_transition(new_state: StringName) -> void:
	if not states.has(new_state):
		push_warning("State '%s' does not exist." % new_state)
		return
	var next_state: State = states.get(new_state)
	if next_state != current_state:
		current_state.exit()
		next_state.enter()
		previous_state = current_state
		current_state = next_state
