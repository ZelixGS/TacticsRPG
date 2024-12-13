class_name Attack extends Spell

const ATTACK = preload("res://Spells/Attack/Attack.tres")

func on_initialize() -> void:
	data = ATTACK.duplicate()

func cast() -> void:
	highlight_range(caster.position, 1)
	var target: Entity = await get_single_target()
	if not target:
		return
	for i: int in get_amount_of_swings():
		var weapon: Item = get_mainhand()
		var damage = Damage.new(weapon.minimum_damage  * data.scaling_coefficent, weapon.maximum_damage * data.scaling_coefficent, 0.05, weapon.damage_type)
		target.take_damage(damage)
	finish_cast()

func get_amount_of_swings() -> int:
	return 1
