class_name HighlightManager extends Node

const HIGHLIGHT = preload("res://Scenes/Grid/Highlights/cell_highlight.png")
const HIGHLIGHT_NO_STROKE = preload("res://Scenes/Grid/Highlights/cell_highlight_no_stroke.png")
const HIGHLIGHT_STROKE_ONLY = preload("res://Scenes/Grid/Highlights/cell_highlight_stroke_only.png")

@onready var movement_highlight: CanvasGroup = $MovementHighlight
@onready var attack_highlight: CanvasGroup = $AttackHighlight
@onready var path_highlight: CanvasGroup = $PathHighlight
@onready var aoe_highlight: CanvasGroup = $AoEHighlight

#region Ready Functions

func _ready() -> void:
	Event.highlight_movement.connect(_update_movement)
	Event.highlight_attack.connect(_update_attack)
	Event.highlight_path.connect(_update_path)
	Event.highlight_aoe.connect(_update_aoe)
	Event.highlight_clear_all.connect(_clear_all)

#endregion

#region Update Highlights

func _clear_all() -> void:
	clear_children(movement_highlight)
	clear_children(attack_highlight)
	clear_children(path_highlight)
	clear_children(aoe_highlight)

func _update_movement(cells: Array[Vector2i]) -> void:
	clear_children(movement_highlight)
	for i: Vector2i in cells:
		add_highlight(Color.BLUE, Grid.cell_to_world(i), movement_highlight, HIGHLIGHT_NO_STROKE)

func _update_attack(cells: Array[Vector2i]) -> void:
	clear_children(attack_highlight)
	for i: Vector2i in cells:
		add_highlight(Color.RED, Grid.cell_to_world(i), attack_highlight, HIGHLIGHT_NO_STROKE)

func _update_path(cells: Array[Vector2i]) -> void:
	clear_children(path_highlight)
	for i: Vector2i in cells:
		add_highlight(Color.YELLOW, Grid.cell_to_world(i), path_highlight, HIGHLIGHT_NO_STROKE)

func _update_aoe(cells: Array[Vector2i]) -> void:
	clear_children(aoe_highlight)
	for i: Vector2i in cells:
		add_highlight(Color.ORANGE, Grid.cell_to_world(i), aoe_highlight, HIGHLIGHT_NO_STROKE)

#endregion

func clear_children(parent: Node) -> void:
	for child in parent.get_children():
		child.queue_free()

func add_highlight(color: Color, position: Vector2i, parent: CanvasGroup, texture: Texture) -> void:
	var s = Sprite2D.new()
	s.texture = texture
	parent.add_child(s)
	s.global_position = position
	s.modulate = color
