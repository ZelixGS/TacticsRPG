class_name AnimatedProgressBar extends TextureProgressBar

@export var gradiant: GradientTexture1D = GradientTexture1D.new()

@export_category("Value Label")
@export var label_settings: LabelSettings
@export var label_show_maximum: bool = true
@export var label_show_percentage: bool = true

@onready var value_label: Label = $MarginContainer/ValueLabel

func _ready() -> void:
	if label_settings:
		value_label.label_settings = label_settings

func update_color() -> void:
	tint_progress = gradiant.gradient.sample(get_percentage())

func get_percentage() -> float:
	return (value / max_value)

func update_value_label() -> void:
	var text: String = "%s" % value
	if label_show_maximum:
		text += "/%s" % max_value
	if label_show_percentage:
		text += " - %s%%" % (value / max_value * 100)
	value_label.text = text

func update(hp_cur: int, hp_max: int) -> void:
	max_value = hp_max
	value = hp_cur
	update_color()
	update_value_label()
