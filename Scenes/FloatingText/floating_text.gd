class_name FloatingText extends Marker2D

@onready var texture_rect: TextureRect = $HBoxContainer/TextureRect
@onready var label: Label = $HBoxContainer/Label

func update(text: Variant, visual: FTVisual, settings: FTSettings) -> void:
	label.text = str(text)
	update_visuals(visual)
	tween_and_free(settings)

func update_visuals(visual: FTVisual) -> void:
	if visual.icon:
		texture_rect.show()
		texture_rect.texture = visual.icon
	if visual.settings:
		label.label_settings = visual.settings
	label.modulate = visual.color

func tween_and_free(settings: FTSettings) -> void:
	#pivot_offset = size / 2
	var tween: Tween = create_tween().set_trans(settings.transition).set_ease(settings.easing)
	if settings.emphasized:
		scale *= 2
	tween.set_parallel(true)
	tween.tween_property(self, "global_position", global_position + settings.travel, settings.duration)
	tween.tween_property(self, "scale", Vector2.ZERO, settings.duration)
	await tween.finished
	call_deferred("queue_free")
