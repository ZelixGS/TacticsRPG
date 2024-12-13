class_name SpellData extends Resource

@export var internal_name: StringName
@export_category("Display")
@export var display_name: StringName
@export var icon: Texture2D
@export_multiline var raw_description: String
@export_category("Stats")
@export var scaling: Enum.SPELL_SCALING = Enum.SPELL_SCALING.ATTACKPOWER
@export var scaling_coefficent: float = 1.0
@export var target: Enum.SPELL_TARGET = Enum.SPELL_TARGET.ENEMY
@export var target_amount: int = 1
@export var damage_modifier: float = 1.0
@export var healing_modifier: float = 1.0
@export var action_points: int = 1
@export var cast_range: int = 0
@export var mana: int = 0
@export var cooldown: int = 0
@export var duration: int = 0
@export var radius: int = 0
@export_category("Visual")
@export var caster_animation: PackedScene
@export var projectile_animation: PackedScene
@export var impact_animation: PackedScene
@export_category("Tooltip")
@export var append_damage: bool = true
@export var append_healing: bool = true
@export var append_action_points: bool = true
@export var append_range: bool = true
@export var append_mana: bool = true
@export var append_cooldown: bool = true
@export var append_duration: bool = true
@export var append_radius: bool = true
@export_category("Properties")
@export var friendly_fire: bool = false

#var tooltip: String:
	#get:
		#return _create_tooltip()

#region Tooltip Creation

#func _create_tooltip() -> String:
	#var description: String = raw_description
	#description = description.replace("{damage}", "%s" % str(damage))
	#description = description.replace("{healing}", "%s" % str(healing))
	#description = description.replace("{action_points}", "%s" % str(action_points))
	#description = description.replace("{range}", "%s" % str(cast_range))
	#description = description.replace("{mana}", "%s" % str(mana))
	#description = description.replace("{cooldown}", "%s" % str(cooldown))
	#description = description.replace("{duration}", "%s" % str(duration))
	#description = description.replace("{radius}", "%s" % str(radius))
	#description = additional_tooltip(description)
	#description = _details()
	#return description
#
#func _details() -> String:
	#var details: String = ""
	#if append_damage:
		#details += new_line(details, "Damage: ", damage)
	#if append_healing:
		#details += new_line(details, "Healing: ", healing)
	#if append_action_points:
		#details += new_line(details, "Action Points: ", action_points)
	#if append_range:
		#details += new_line(details, "Range: ", cast_range)
	#if append_mana:
		#details += new_line(details, "Mana: ", mana)
	#if append_cooldown:
		#details += new_line(details, "Cooldown ", cooldown)
	#if append_duration:
		#details += new_line(details, "Duration: ", duration)
	#if append_radius:
		#details += new_line(details, "Radius: ", radius)
	#details = additional_details(details)
	#return details
#
#func new_line(current_details: String, text: String, value: Variant) -> String:
	#var line: String = ""
	#if current_details.length() > 0:
		#line += "\n"
	#line += "%s%s" % [text, value]
	#return line
#
##endregion
#
#func additional_tooltip(description: String) -> String:
	#return description
#
#func additional_details(details: String) -> String:
	#return details
#
#func cast() -> void:
	#push_warning("Ability [%s] attempted to 'cast()' with no override." % internal_name)
#
#func apply_effect() -> void:
	#push_warning("Ability [%s] attempted to 'apply_effect()' with no override." % internal_name)
