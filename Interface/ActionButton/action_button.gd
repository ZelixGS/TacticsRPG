class_name ActionButton extends Button

var spell: Spell

@onready var cooldown: TextureProgressBar = %Cooldown
@onready var spell_icon: TextureRect = %SpellIcon
@onready var keybind: Label = %Keybind

#func set_spell(new_spell: Spell) -> void:
	#if spell:
		#spell.disconnect()
#
	#spell = new_spell
