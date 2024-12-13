extends Control

@export var selected_name: Label
@export var selected_portrait: TextureRect
@export var selected_health: ProgressBar
@export var selected_movement: ProgressBar

var selected_entity: Entity

func _ready() -> void:
	Event.cursor_selected.connect(unit_selected)
	Event.player_deselected_entity.connect(unit_deselected)

func _process(_delta: float) -> void:
	if selected_entity:
		update_movement(selected_entity)

func unit_selected(entity: Entity) -> void:
	selected_entity = entity
	update_name()

func unit_deselected() -> void:
	selected_entity = null

#region Updates

func update_name(entity: Entity = selected_entity) -> void:
	selected_name.text = entity.display_name

#func update_portrait(entity: Entity) -> void:
#func update_health(entity: Entity) -> void:

func update_movement(entity: Entity = selected_entity) -> void:
	selected_movement.max_value = entity.stats.movement_speed
	selected_movement.value = entity.current_movement

#endregion


func _on_button_pressed() -> void:
	if selected_entity:
		Event.entity_undo_movement.emit(selected_entity)


func _on_ability_button_1_pressed() -> void:
	if selected_entity:
		selected_entity.spells[0].cast()
