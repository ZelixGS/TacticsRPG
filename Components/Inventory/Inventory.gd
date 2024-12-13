@icon("./icon_bag.png")
class_name Inventory extends Resource

enum SLOT { NONE, HEAD, ARMOR, BOOTS, GLOVES, RING, AMULET, MAINHAND, OFFHAND }

@export var head:  Item
@export var armor: Item
@export var boots: Item
@export var gloves: Item
@export var ring: Item
@export var neck: Item
@export var mainhand: Item
@export var offhand: Item

var slots: Array[Slot] = []

func has_item(item: Item) -> bool:
	for i: Slot in slots:
		if i.item.internal_name == item.internal_name:
			return true
	return false

func get_slot(item: Item) -> Slot:
	var index: int = 0
	for i: Slot in slots:
		if i.item.internal_name == item.internal_name:
			return slots[index]
		index += 1
	return null

func add_item(item: Item, amount: int = 1) -> void:
	if item.stackable:
		stack_item(item, amount)
	else:
		slots.append(Slot.new(item, amount))

func stack_item(item: Item, amount: int) -> void:
	for slot: Slot in slots:
		if amount == 0:
			break
		if slot.item.internal_name != item.internal_name:
			continue
		var difference: int = item.max_stack - slot.amount
		slot.amount += difference
		amount -= difference
	if amount > 0:
		slots.append(Slot.new(item, amount))


func remove_item(_item: Item) -> void:
	return

func use_item(_item: Item) -> void:
	return

func equip_item(item: Item) -> void:
	if item.type in [Item.TYPE.NONE, Item.TYPE.CONSUMABLE]:
		return

	return

func unequip_item(_item: Item) -> void:
	return

#region Slot Class
class Slot extends RefCounted:
	var item: Item
	var amount: int
	func _init(item_: Item, amount_: int = 1) -> void:
		item = item_
		amount = amount_
#endregion
