@icon("./icon_grid.png")
class_name Grid extends Node2D

static var cell_size: Vector2i = Vector2i(16, 16)

var astar: AStarGrid2D
var dijkstra: Dijkstra

#region Ready Functions

func _ready() -> void:
	dijkstra = Dijkstra.new(Vector2i(50, 50))
	_setup_astar()
	_connect_signals()

func _connect_signals() -> void:
	Event.cursor_selected.connect(unit_selected)
	Event.cursor_deselected.connect(unit_deselected)
	#Event.entity_undo_movement.connect(attempt_undo_movement)

func _setup_astar() -> void:
	astar = AStarGrid2D.new()
	astar.region = Rect2i(0, 0, 32, 32)
	astar.cell_size = cell_size
	astar.offset = cell_size / 2
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()

#endregion

#region Cell Functions

static func world_to_cell(v2: Vector2) -> Vector2i:
	return floor(v2) / Vector2(cell_size.x, cell_size.y)

static func cell_to_world(v2: Vector2i) -> Vector2:
	return v2 * cell_size + (cell_size/2)

func mouse_to_cell() -> Vector2i:
	return world_to_cell(get_global_mouse_position())

#endregion

#region Entity Management

# func get_entity_by_name(display_name: StringName) -> Entity:
# 	var entities: Array[Entity] = get_entities()
# 	for e: Entity in entities:
# 		if e.display_name == display_name:
# 			return e
# 	return null

# func get_entity_by_vector2(v2: Vector2i) -> Entity:
# 	var entities: Array[Entity] = get_entities()
# 	for e: Entity in entities:
# 		if get_cell(e.global_position) == v2:
# 			return e
# 	return null

# func get_entities() -> Array[Entity]:
# 	var new_array: Array[Entity] = []
# 	for node: Node in get_tree().get_nodes_in_group("entity"):
# 		if node is Entity:
# 			new_array.append(node)
# 	return new_array

# func get_entities_cells() -> Array[Vector2i]:
# 	return entities_to_tiles(get_entities())

# func entities_to_tiles(entities: Array[Entity]) -> Array[Vector2i]:
# 	var new_array: Array[Vector2i] = []
# 	for node: Entity in entities:
# 		new_array.append(get_cell(node.global_position))
# 	return new_array

#endregion

func get_movement_cells(entity: Entity) -> Array[Vector2i]:
	return dijkstra.get_cells(world_to_cell(entity.global_position), entity.current_movement)

func request_move(entity: Entity, destination: Vector2i) -> void:
	if entity.is_moving:
		return
	var path: PackedVector2Array = astar.get_point_path(world_to_cell(entity.global_position), destination)
	path.remove_at(0)
	await entity.move(path)
	if entity.current_movement > 0:
		Event.highlight_movement.emit(get_movement_cells(entity))

func attempt_undo_movement(entity: Entity) -> void:
	entity.undo_movement()
	if entity.current_movement > 0:
		Event.highlight_movement.emit(get_movement_cells(entity))

#func _get_movement_path(a: Vector2i, b: Vector2i) -> Array[Vector2]:
	#var path: PackedVector2Array = astar.get_point_path(a, b)
	#var new_array: Array[Vector2] = []
	#for p: Vector2 in path:
		#if p == path[0]:
			#continue
		#new_array.append(p + (Vector2(cell_size.x, cell_size.y) / 2))
	#print(new_array.size())
	#return new_array

func unit_selected(entity: Entity) -> void:
	Event.highlight_movement.emit(get_movement_cells(entity))

func unit_deselected() -> void:
	var empty: Array[Vector2i] = []
	Event.highlight_movement.emit(empty)
	pass

static func get_distance(a: Vector2i, b: Vector2i) -> float:
	return (abs(a.x - b.x) + abs(a.y - b.y)) / 16

static func get_radius(center: Vector2, radius: float) -> Array[Vector2i]:
	var tiles: Array[Vector2i] = []
	for x: int in range(ceil(center.x - radius), floor(center.x + radius)+1):
		for y: int in range(ceil(center.y - radius), floor(center.y + radius)+1):
			var tile: Vector2i = Vector2i(x, y)
			if is_inside_circle(center, tile, radius):
				tiles.append(tile)
	return tiles

static func is_inside_circle(center: Vector2, tile: Vector2, radius: float) -> bool:
	var dx: float = center.x - tile.x
	var dy: float = center.y - tile.y
	var distance_squared: = (dx*dx) + (dy*dy)
	return distance_squared <= radius*radius
