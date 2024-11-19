class_name MovementAction extends RefCounted

var position: Vector2
var cost: int

func _init(position_: Vector2, cost_: int) -> void:
	position = position_
	cost = cost_
