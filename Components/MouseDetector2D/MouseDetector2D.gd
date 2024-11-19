@icon("./icon_target.png")
class_name MouseDetector2D extends Area2D

signal entered
signal exited

@export_category("Mouse Entered")
@export var mouse_entered_signal: bool = true
@export var mouse_entered_node: Node
@export var mouse_entered_method: StringName = "on_mouse_entered"
@export_category("Mouse Exited")
@export var mouse_exited_signal: bool = true
@export var mouse_exited_node: Node
@export var mouse_exited_method: StringName = "on_interaction"

#region Enable/Disable/Toggle
func enable() -> void:
	set_deferred("monitoring", true)

func disable() -> void:
	set_deferred("monitoring", false)

func toggle() -> void:
	set_deferred("monitoring", !monitoring)
#endregion

func _on_mouse_entered() -> void:
	print("Mouse!")
	if mouse_entered_signal:
		entered.emit()
	if mouse_entered_node:
		if mouse_entered_node.has_method(mouse_entered_method):
			mouse_entered_node.call(mouse_entered_method)
		else:
			push_error("[MouseDetector2D] %s.%s is missing '%s' Method." % [mouse_entered_node.owner.name, mouse_entered_node.name, mouse_entered_method])

func _on_mouse_exited() -> void:
	if mouse_exited_signal:
		exited.emit()
	if mouse_exited_node:
		if mouse_exited_node.has_method(mouse_exited_method):
			mouse_exited_node.call(mouse_exited_method)
		else:
			push_error("[MouseDetector2D] %s.%s is missing '%s' Method." % [mouse_exited_node.owner.name, mouse_exited_node.name, mouse_exited_method])
