extends Node

var _debug_console: DebugConsole

func add_property(title: String, value: Variant, order: int = 0) -> void:
	var stringify: String = str(value)
	_debug_console.add_property(title, stringify, order)
