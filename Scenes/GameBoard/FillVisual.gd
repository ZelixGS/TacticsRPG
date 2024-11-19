extends TileMapLayer

const FILL: int = 0

func _ready() -> void:
	clear()

func fill(tiles: Array[Vector2i]) -> void:
	for cell: Vector2i in tiles:
		set_cell(cell, 0, Vector2i(7, 4))
		#await await get_tree().create_timer(0.0001).timeout

#func fill(center: Vector2i, radius: float) -> void:
	#var top: int = ceil(center.y - radius)
	#var bottom: int = floor(center.y + radius)
	#var left: int = ceil(center.x - radius)
	#var right: int = floor(center.x + radius)
#
	#print("===========")
	#for y: int in range(top, bottom+1):
		#for x: int in range(left, right+1):
			#var tile: Vector2i = Vector2i(x, y)
			#print(tile)
			#if is_inside_circle(center, tile, radius):
				#set_cell(tile, 0, Vector2i(7, 4))

func is_inside_circle(center: Vector2, tile: Vector2, radius: float) -> bool:
	var dx: float = center.x - tile.x
	var dy: float = center.y - tile.y
	var distance_squared: = (dx*dx) + (dy*dy)
	return distance_squared <= radius*radius
