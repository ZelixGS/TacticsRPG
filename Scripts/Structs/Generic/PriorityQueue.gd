class_name PriorityQueue extends RefCounted

var front: LinkedNode
var new_node: LinkedNode
var temp: LinkedNode

func _init() -> void:
	front = null

func is_empty() -> bool:
	return front == null

func push(value: Vector2i, priority: int) -> void:
	if is_empty():
		front = LinkedNode.new(value, priority)
	elif front.priority > priority:
		new_node = LinkedNode.new(value, priority, front)
		new_node.next = front
		front = new_node
	else:
		temp = front

		while temp.next:
			if priority <= temp.next.priority:
				break
			temp = temp.next
		new_node = LinkedNode.new(value, priority, temp.next)
		temp.next = new_node

func pop() -> LinkedNode:
	if is_empty():
		return null
	else:
		temp = front
		front = front.next
		return temp