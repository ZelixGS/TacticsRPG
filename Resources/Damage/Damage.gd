@icon("./icon_sword.png")
class_name Damage extends Resource

enum TYPE { DAMAGE, HEAL }
enum ELEMENT { PHYSICAL, MAGICAL, ARCANE, FIRE, COLD, LIGHTNING, POISON, ACID, HOLY, SHADOW, ELDRICH }

@export_subgroup("Amount")
@export var amount: int = 0

@export_subgroup("Varience")
@export var has_varience: bool = true
@export var min_varience: float = 0.9
@export var max_varience: float = 1.1

@export_subgroup("Type")
@export var type: TYPE = TYPE.DAMAGE
@export var element: ELEMENT = ELEMENT.PHYSICAL

@export_subgroup("Critical Chance")
@export var can_critically_strike: bool = true
@export var critical_chance: float = 0.05
@export var critical_modifier: float = 2.0

@export_subgroup("Invincibility Frames")
@export var ignore_invincibility_time: bool = false
@export var start_invincibility_time: bool = true

@export_subgroup("Misc")
@export var dodgable: bool = true
@export var parryable: bool = true
@export var blockable: bool = true

func _init(_amount: int, _type: TYPE = TYPE.DAMAGE, _critical_chance: float = 0.05, _ignore_invincibility_time: bool = false, _start_invincibility_time: bool = true) -> void:
	amount = _amount
	type = _type
	critical_chance = _critical_chance
	ignore_invincibility_time = _ignore_invincibility_time
	start_invincibility_time = _start_invincibility_time

func get_damage() -> RolledDamage:
	return RolledDamage.new()

func roll_variance() -> float:
	return randf_range(min_varience, max_varience)

func roll_critical() -> bool:
	if not can_critically_strike:
		return false
	var roll: float = randf_range(0.0, 100.0)
	if roll < critical_chance:
		return true
	return false
