class_name Damage extends RefCounted

var amount: int
var min_varience: int
var max_varience: int

var type: Enum.DAMAGE_TYPE = Enum.DAMAGE_TYPE.MELEE
var element: Enum.ELEMENT = Enum.ELEMENT.PHYSICAL

var critical_chance: float = 0.0
var critical_modifier: float = 2.0

var is_critical: bool = true
var is_dodgable: bool = true
var is_parryable: bool = true
var is_blockable: bool = true

func _init(min_: int, max_: int, critical_chance_: float, element_: Enum.ELEMENT) -> void:
	min_varience = min_
	max_varience = max_
	critical_chance = critical_chance_
	element = element_
	roll_damage()
	roll_critical()

func roll_damage(modifier: int = 0) -> void:
	amount = (randi_range(min_varience, max_varience) + modifier)

func roll_critical(modifier: float = 0.0) -> void:
	var roll: float = randf_range(0.0, 100.0)
	if roll < (critical_chance + modifier):
		is_critical = true
