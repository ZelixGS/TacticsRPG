extends Node

const _FLOATING_TEXT: PackedScene = preload("res://Scenes/FloatingText/FloatingText.tscn")

func floating_text(text: Variant, position: Vector2, color: Color = Color.WHITE, visuals: FTVisual = null, settings: FTSettings = null) -> void:
	if not visuals:
		visuals = FTVisual.new()
	if not settings:
		settings = FTSettings.new()
	visuals.color = color
	var ft: FloatingText = _FLOATING_TEXT.instantiate()
	get_tree().current_scene.add_child(ft)
	ft.global_position = position
	ft.update(text, visuals, settings)
