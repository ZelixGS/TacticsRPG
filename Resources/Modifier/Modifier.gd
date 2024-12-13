class_name Modifier extends RefCounted

var name: String

func apply() -> void:
	push_error("%s is missing apply() override" % self)

func _to_string() -> String:
	return "%s is missing to_string() override" % self
