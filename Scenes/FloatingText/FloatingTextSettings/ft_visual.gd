class_name FTVisual extends RefCounted

var color: Color
var icon: Texture
var settings: LabelSettings

func _init(color_: Color = Color.WHITE, icon_: Texture = null, settings_: LabelSettings = null) -> void:
	color = color_
	icon = icon_
	settings = settings_
