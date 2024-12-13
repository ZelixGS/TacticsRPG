@icon("./icon_target.png")
class_name MouseDetector2D extends Area2D

signal input(mouse_position: Vector2)
signal entered(mouse_position: Vector2)
signal exited(mouse_position: Vector2)

@export var detect_input: bool = false
@export var detect_enter: bool = false
@export var detect_exit: bool = false
@export_category("Mouse Input")
@export var mouse_input: StringName = "left click"
@export var mouse_input_signal: bool = true
@export var mouse_input_node: Node
@export var mouse_input_method: StringName = "on_mouse_input"
@export_category("Mouse Entered")
@export var mouse_entered_signal: bool = true
@export var mouse_entered_node: Node
@export var mouse_entered_method: StringName = "on_mouse_entered"
@export_category("Mouse Exited")
@export var mouse_exited_signal: bool = true
@export var mouse_exited_node: Node
@export var mouse_exited_method: StringName = "on_mouse_exited"

func _ready() -> void:
	set_deferred("monitorable", false)
	if detect_input:
		input_event.connect(_on_input_event)
	if detect_enter:
		mouse_entered.connect(_on_mouse_entered)
	if detect_exit:
		mouse_exited.connect(_on_mouse_exited)

#region Enable/Disable/Toggle
func enable() -> void:
	set_deferred("monitoring", true)

func disable() -> void:
	set_deferred("monitoring", false)

func toggle() -> void:
	set_deferred("monitoring", !monitoring)
#endregion

func _on_mouse_entered() -> void:
	if mouse_entered_signal:
		entered.emit(get_global_mouse_position())
	if mouse_entered_node:
		if mouse_entered_node.has_method(mouse_entered_method):
			mouse_entered_node.call(mouse_entered_method, get_global_mouse_position())
		else:
			push_error("[MouseDetector2D] %s.%s is missing '%s' Method." % [mouse_entered_node.owner.name, mouse_entered_node.name, mouse_entered_method])

func _on_mouse_exited() -> void:
	if mouse_exited_signal:
		exited.emit(get_global_mouse_position())
	if mouse_exited_node:
		if mouse_exited_node.has_method(mouse_exited_method):
			mouse_exited_node.call(mouse_exited_method, get_global_mouse_position())
		else:
			push_error("[MouseDetector2D] %s.%s is missing '%s' Method." % [mouse_exited_node.owner.name, mouse_exited_node.name, mouse_exited_method])


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed(mouse_input):
		if mouse_input_signal:
			input.emit(get_global_mouse_position())
		if mouse_input_node:
			if mouse_input_node.has_method(mouse_input_method):
				mouse_input_node.call(mouse_input_method, get_global_mouse_position())
			else:
				push_error("[MouseDetector2D] %s.%s is missing '%s' Method." % [mouse_input_node.owner.name, mouse_input_node.name, mouse_input_method])
