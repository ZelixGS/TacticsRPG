class_name State extends Node

@warning_ignore("unused_signal")
signal transition(new_state: StringName)

var actor: Node2D

func _ready() -> void:
	# StateMachine handles getting who it handles the state of, attempt to get a link to it.
	var parent: StateMachine = get_parent()
	if parent:
		actor = parent.actor

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func unhandled_input(_event: InputEvent) -> void:
	pass
