@icon("./icon_pot.png")
class_name Item extends Resource

enum TYPE { NONE, ARMOR, WEAPON, CONSUMABLE }
enum SUBTYPE { NONE, MELEE, RANGE, FOCI }

@export var internal_name: StringName
@export var display_name: StringName
@export var icon: Texture2D
@export_multiline var description: String

@export var stackable: bool = false
@export var max_stack: int = 1
@export var type: TYPE = TYPE.NONE
@export var slot: Enum.INVENTORY_SLOT = Enum.INVENTORY_SLOT.ONEHAND

#region Weapon Stats
@export var minimum_damage: int = 0
@export var maximum_damage: int = 0
@export var damage_type: Enum.ELEMENT = Enum.ELEMENT.PHYSICAL
@export var attack_range: int = 1
#endregion
