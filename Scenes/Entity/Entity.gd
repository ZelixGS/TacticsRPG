@icon("./icon_character.png")
class_name Entity extends CharacterBody2D

signal started_movement
signal finished_movement

@export var display_name: StringName
@export var faction: Enum.FACTION = Enum.FACTION.ENEMY

@export_category("Components")
@export var stats: Stats
@export var inventory: Inventory
@export var health: HealthComponent
var spells: Array[Spell]

@export var label: Label

var is_moving: bool = false

var current_movement: int
var current_actions: int

var last_movements: Array[MovementAction]

func _ready() -> void:
	spells.append(Attack.new(self))
	if display_name.is_empty():
		display_name = name
	else:
		name = display_name
	current_movement = stats.movement_speed
	if label:
		label.text = display_name
	add_to_group("entity")

func move(path: PackedVector2Array) -> void:
	if is_moving:
		return
	is_moving = true
	started_movement.emit()
	var start_position: Vector2 = global_position
	var movements: int = 0
	for cell: Vector2i in path:
		var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(self, "global_position", Vector2(cell.x, cell.y), 0.15)
		await tween.finished
		movements += 1
		current_movement -= 1
	last_movements.push_front(MovementAction.new(start_position, movements))
	is_moving = false
	finished_movement.emit()

func undo_movement() -> void:
	if last_movements.size() == 0:
		return
	var last_action: MovementAction = last_movements.pop_front()
	global_position = last_action.position
	current_movement += last_action.cost

func refresh() -> void:
	current_movement = stats.movement_speed
	current_actions = stats.action_points

func take_damage(damage: Damage) -> void:
	health.change_health(damage)

func _on_mouse_detector_2d_input(_mouse_position: Vector2) -> void:
	Event.ui_mouseover_hud.emit(self)

func _on_mouse_detector_2d_entered(_mouse_position: Vector2) -> void:
	Event.ui_mouseover_hud.emit(self)


func _on_health_damaged(damage: Damage) -> void:
	Create.floating_text(damage.amount, global_position, Color.RED)


func _on_health_healed(damage: Damage) -> void:
	Create.floating_text(damage.amount, global_position + Vector2(0, -8), Color.GREEN)
	pass # Replace with function body.
