class_name LinkedNode extends RefCounted

var value: Vector2i
var priority: int
var next: LinkedNode

func _init(value_: Vector2i, priority_: int, node_: LinkedNode = null) -> void:
	value = value_
	priority = priority_
	next = node_