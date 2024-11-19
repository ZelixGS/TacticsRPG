class_name Dijkstra extends RefCounted

const MAX_VALUE : int = 999999
const DIRECTIONS: Array[Vector2i] = [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]

var size: Vector2i

func _init(size_: Vector2i) -> void:
	size = size_

func get_terrain_cost(cell: Vector2i, occupided_cells: Array[Vector2i]) -> float:
	if cell in occupided_cells:
		return MAX_VALUE
	# TODO Add Unit Logic
	return 1.0

func is_within_bounds(cell: Vector2i) -> bool:
	var out: bool = cell.x >= 0 and cell.x < size.x
	return out and cell.y >= 0 and cell.y < size.y

func get_cells(center: Vector2i, steps: int, occupided_cells: Array[Vector2i] = []) -> Array[Vector2i]:
	var movable_cells: Array[Vector2i] = []
	var visited: Array[Array] = []
	var distances: Array[Array] = []
	var previous: Array[Array] = []

	for y: int in size.y:
		visited.append([])
		distances.append([])
		previous.append([])
		for x: int in size.x:
			visited[y].append(false)
			distances[y].append(MAX_VALUE)
			previous[y].append(null)

	var queue: PriorityQueue = PriorityQueue.new()

	queue.push(center, 0)
	distances[center.y][center.x] = 0

	var distance: float

	while not queue.is_empty():
		var current: LinkedNode = queue.pop()
		visited[current.value.y][current.value.x] = true

		for direction in DIRECTIONS:
			var coordinates: Vector2i = current.value + direction
			if is_within_bounds(coordinates):
				if visited[coordinates.y][coordinates.x]:
					continue
				else:
					var cost: float = get_terrain_cost(coordinates, occupided_cells)
					distance = current.priority + cost

					visited[coordinates.y][coordinates.x] = true
					distances[coordinates.y][coordinates.x] = distance

				if distance <= steps:
					previous[coordinates.y][coordinates.x] = current.value
					movable_cells.append(coordinates)
					queue.push(coordinates, floor(distance))

	return movable_cells
