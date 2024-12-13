class_name MouseOverPanel extends Control

@export var faction: Enum.FACTION = Enum.FACTION.PLAYER

@onready var label: Label = %Label
@onready var animated_progress_bar: AnimatedProgressBar = %AnimatedProgressBar

func _ready() -> void:
	Event.ui_mouseover_hud.connect(update)

func update(entity: Entity) -> void:
	if entity.faction == faction:
		return
	label.text = entity.name
	animated_progress_bar.update(floori(entity.health.health), floori(entity.health.max_health))
