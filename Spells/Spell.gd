class_name Spell extends RefCounted

signal update_cooldown()

var caster: Entity
var data: SpellData
var targets: Array[Entity]

var cooldown: int = 0:
	set(value):
		cooldown = value
		update_cooldown.emit()

func _init(caster_: Entity) -> void:
	caster = caster_
	on_initialize()

func on_initialize() -> void:
	push_error("[Spell] %s has no defined on_initialize()." % [data.internal_name])

func cast() -> void:
	push_error("[Spell] %s has no defined cast()." % [data.internal_name])

func npc_cast(_caster: Entity, _target: Variant) -> void:
	push_error("[Spell] %s has no defined npc_cast()." % [data.internal_name])

func finish_cast() -> void:
	targets.clear()

#region Conditions

func is_target_valid(entity: Entity) -> bool:
	match data.target:
		Enum.SPELL_TARGET.SELF:
			return is_self(entity)
		Enum.SPELL_TARGET.FRIENDLY:
			return is_friendly(entity)
		Enum.SPELL_TARGET.ENEMY:
			return is_hostile(entity)
		_:
			return false

func is_self(entity: Entity) -> bool:
	return caster == entity

func is_friendly(entity: Entity) -> bool:
	return caster.faction == entity.faction

func is_hostile(entity: Entity) -> bool:
	return caster.faction != entity.faction

func is_in_range(entity: Entity) -> bool:
	return Grid.get_distance(Grid.world_to_cell(caster.position), Grid.world_to_cell(entity.position)) <= data.cast_range

#endregion

#region Targeting

func add_target(entity: Entity) -> void:
	if is_target_valid(entity) and is_in_range(entity):
		targets.append(entity)
	if targets.size() == data.target_amount:
		Event.spell_stop_targeting.emit()

func remove_target() -> void:
	var target: Entity = targets.pop_back()
	if target == null:
		Event.spell_stop_targeting.emit()

func get_single_target() -> Entity:
	Event.cursor_request_entities.emit(self)
	await Event.spell_stop_targeting
	if targets.size() > 0:
		return targets.front()
	return null

func get_multiple_targets() -> Array[Entity]:
	Event.cursor_request_entities.emit()
	await Event.spell_stop_targeting
	return targets

#endregion

#region Inventory

func get_mainhand() -> Item:
	return caster.inventory.mainhand

func get_offhand() -> Item:
	return caster.inventory.offhand

#endregion

func highlight_range(center: Vector2i, cast_range: float = data.cast_range) -> void:
	Event.highlight_clear_all.emit()
	Event.highlight_attack.emit(Grid.get_radius(Grid.world_to_cell(center), cast_range))
