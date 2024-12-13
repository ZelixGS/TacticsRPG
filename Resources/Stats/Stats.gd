@icon("./icon_stat.png")
class_name Stats extends Resource


#region Overview
# Might inceases Damage, Armor, and Block Amount
# Alacrity increases Critical Strike & Dodge Chance, Movement Speed
# Brilliance increases Mana Pool & Elemental Resistance
# Fortitude increases Health, Block Chance
# Resolve increses Parry, Thorns, Health Recovery & Mana Regeneration, and ...
# Luck increases increases Proc Chance, gold find, and treasure find.
#endregion

#region Primary Stats

@export_group("Primary")
@export_subgroup("Base")
@export var might_base: int = 0
@export var alacrity_base: int = 0
@export var brilliance_base: int = 0
@export var fortitude_base: int = 0
@export var resolve_base: int = 0
@export var luck_base: int = 0
@export_subgroup("Modifiers")
@export var might_modifier: float = 1.0
@export var alacrity_modifier: float = 1.0
@export var brilliance_modifier: float = 1.0
@export var fortitude_modifier: float = 1.0
@export var resolve_modifier: float = 1.0
@export var luck_modifier: float = 1.0

func get_might() -> int:
	return floor(might_base * might_modifier)

func get_alacrity() -> int:
	return floor(alacrity_base * alacrity_modifier)

func get_brilliance() -> int:
	return floor(brilliance_base * brilliance_modifier)

func get_fortitude() -> int:
	return floor(fortitude_base * fortitude_modifier)

func get_resolve() -> int:
	return floor(resolve_base * resolve_modifier)

func get_luck() -> int:
	return floor(luck_base * luck_modifier)

#endregion

#region Health

@export_group("Health")
@export var health_base: int = 100
@export var health_modifier: float = 1.0
@export var health_from_fortitude: int = 5

func get_health_max() -> int:
	return floor((health_base + (get_fortitude() * health_from_fortitude)) * health_modifier)

@export_subgroup("Health Regeneration")
@export var health_regeneration: int = 0
@export var health_regeneration_from_resolve: int = 10

func get_health_regeneration() -> int:
	@warning_ignore("integer_division")
	return floor(health_regeneration + floor(get_resolve() / health_regeneration_from_resolve))

#endregion

#region Mana

@export_group("Mana")
@export var mana_base: int = 50
@export var mana_modifier: float = 1.0
@export var mana_from_brilliance: int = 5

func get_mana_max() -> int:
	return floor((mana_base + floor(get_brilliance() * mana_from_brilliance)) * mana_modifier)

@export_subgroup("Mana Replenishment")
@export var mana_replenishment: int = 0
@export var mana_replenishment_from_resolve: int = 5

func get_mana_replenishment() -> int:
	@warning_ignore("integer_division")
	return floor(mana_replenishment + floor(get_resolve() / mana_replenishment_from_resolve))

#endregion

#region Offensive

@export_group("Offensive")
@export_subgroup("Critical Strike")
@export var critical_chance_base: float = 0.05
@export var critical_modifier_base: float = 1.0
@export var critical_chance_limit: float = 1.0
@export var critical_chance_from_alacity: float = 0.3

#endregion

#region Defensive

@export_group("Defenseive")
@export_group("Dodge")
@export var dodge_chance_base: float = 0.05
@export var dodge_chance_modifier: float = 1.0
@export var dodge_chance_limit: float = 0.75
@export var dodge_chance_from_alacity: float = 0.25
@export_group("Parry")
@export var parry_chance_base: float = 0.05
@export var parry_chance_modifier: float = 1.0
@export var parry_chance_limit: float = 0.75
@export var parry_chance_from_resolve: float = 0.3

func get_dodge_chance() -> float:
	return min(dodge_chance_base + (get_alacrity() * dodge_chance_from_alacity), dodge_chance_limit)

#endregion

#region Misc

@export_subgroup("Misc")
@export_group("Action Points")
@export var action_points: int = 1
@export_group("Movement Speed")
@export var movement_speed: int = 5
