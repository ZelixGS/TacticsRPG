@tool
class_name AnimatedProgressBar extends TextureProgressBar

@export var gradiant: GradientTexture1D = GradientTexture1D.new()

@export_category("Value Label")
@export var value_label: Label
@export var label_settings: LabelSettings:
	set(value):
		label_settings = value
		if value_label:
			value_label.label_settings = label_settings
@export var label_show_maximum: bool = true:
	set(value):
		label_show_maximum = value
		update_value_label()
@export var label_show_percentage: bool = true:
	set(value):
		label_show_percentage = value
		update_value_label()


func update_color() -> void:
	tint_progress = gradiant.gradient.sample(get_percentage())

func get_percentage() -> float:
	return (value / max_value)

func update_value_label() -> void:
	if value_label:
		var text: String = "%s" % value
		if label_show_maximum:
			text += "/%s" % max_value
		if label_show_percentage:
			text += " - %s%%" % (value / max_value * 100)
		value_label.text = text

func _on_changed() -> void:
	update_value_label()

func _on_value_changed(value: float) -> void:
	update_value_label()
	update_color()
