@icon("./icon_heart.png")
class_name Health extends Node

## The Health Component is used to give any node it's attached to, all health related functions.[br][br]
##
## This component offers a variety of functions that can be personalized for each instance, including clamping health values, ignoring all damage taken,
## exceeding maximum health, limiting damage intake with a timer, emitting signals for damage/heal text, and updating health bars.[br][br]
##
## The [Health] Component is closely tied to a [Damage] object which has properties and methods that will be used when calculating random damage, critical strikes, and ignoring invincibility timer. [br]([Damage] objects can [u]NEVER[/u] ignore [member god_mode])[br][br]
## Methods are also provided to forcibly cause damage and healing, primarily used for scripting interactions. [br](Which [u]CAN[/u] ignore [member god_mode])[br][br]
##
## TODO:[br]
## 1. Add Disallow Healing.[br]
## 2. Disable Healing if at 0 [member health].[br]
## 3. Add Resurrection method?[br]
## 2. Add Linkable Components. (Mitigation?, Drop, Death)[br]

signal health_changed(current: int, max: int) ## Emitted every time health is changed in a neutral context, should be used with Health related Interface functions
signal damaged(damage: Damage) ## Emitted when health is changed in a negative context. The [Damage] Object is passed with it for further interaction scripting.
signal healed(damage: Damage) ## Emitted when health is changed in a postive context. The [Damage] Object is passed with it for further interaction scripting.
signal died ## Emitted when health has reached 0, any [Drop] or [Death] Components will be called if linked.

@export var max_health: float = 10: ## The maximum amount of health this component can have normally. By default on creation current health will be set to [code]max_health[/code]
	set(value):
		var previous: float = max_health
		max_health = value
		if heal_difference:
			health += max_health - previous
		health = clamp(health, 0, max_health)
		health_changed.emit(health, max_health)

@export var invincibility_time: float = 0 ## The standard amount of time a damage event will be registered. Setting this to 0 cause all damage to be registered.[br](This does [u]not[/u] effect healing.)
@export var exceed_maximum_health: bool = false ## Allows current health to exceed [code]max_health[/code], used in niche situations.
@export var heal_difference: bool = true ## When modifying maximum health if it should grant the health gained from maximum health increaseing.
#TODO @export_group("Linked Components")
#TODO @export var drop_component: Node ## When linked, a call will be sent to this component which will typically drop loot.
#TODO @export var death_component: Node ## When linked, a call will be sent to this component which will typically handle default deaths.
@export_group("Debug")
@export var god_mode: bool = false ## Causes all damage to be ignored unless forced by [method force_damage]. This does not stop healing from occuring.[br][u][Damage] objects will [b]NEVER[/b] ignore [member god_mode][/u].

var _invincibility_timer: Timer = Timer.new()

var health: float = max_health: ## The current health of the player. Will automatically clamp any value changes to 0 or [code]max_health[/code] unless [code]exceed_maximum_health[/code] is enabled.
	set(value):
		if exceed_maximum_health:
			health = max(0, value)
		else:
			health = clamp(value, 0, max_health)
		health_changed.emit(health, max_health)

# Creates a timer with proper settings on ready, this is primarily used for invincibility timings.
# Damage Objects have a property to ignore the invincibility timer as well.
func _ready() -> void:
	_invincibility_timer.one_shot = true
	_invincibility_timer.autostart = false
	add_child(_invincibility_timer)

## The primary method to effect the health of the component and will follow or ignore rules based on a [Damage] object.[br][br]
## Expected Operations:[br]
## 1. You can always be healed despite [member god_mode][br]
## 2. If [member god_mode] is enabled, exit early.[br]
## 3. Attempting to cause Damage will check [member invincibility_time]. (Unless [Damage] instructs otherwise.)[br]
## 4. After taking damage a timer will be started [member invincibility_time]. (Unless [Damage] instructs otherwise.)[br]
## 5. Lastly if [member health] is equal to 0, [signal died] will be emitted and any linked components will be called.[br]
func change_health(damage: Damage) -> void:
	if damage.type == damage.TYPE.HEAL:
		health += damage.amount
		healed.emit(damage)

	if god_mode:
		return

	if damage.type == damage.TYPE.DAMAGE:
		if not damage.ignore_invincibility_time:
			if not _invincibility_timer.is_stopped():
				return
		health -= damage.amount
		damaged.emit(damage)
		if damage.start_invincibility_time:
			_invincibility_timer.start(invincibility_time)
		if health == 0:
			_death()

func _death() -> void:
	died.emit()

#region Force Methods

## This method will forcibly cause damage, and can be set to ignore [member god_mode].[br]
## [u]This is not the intended way to cause damage or healing and shoud be used scripting scenarios.[/u]
func force_damage(amount: int, ignore_god_mode: bool = false) -> void:
	var current_god_status: bool = god_mode
	if ignore_god_mode:
		god_mode = false
	var dmg_obj: Damage = Damage.new(amount, Damage.TYPE.DAMAGE, 0, true, false)
	change_health(dmg_obj)
	god_mode = current_god_status


## This method will forcibly increase health.[br]
## [u]This is not the intended way to cause damage or healing and shoud be used scripting scenarios.[/u]
func force_heal(amount: int) -> void:
	var dmg_obj: Damage = Damage.new(amount, Damage.TYPE.HEAL)
	change_health(dmg_obj)

#endregion
