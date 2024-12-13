class_name FillLayer extends TileMapLayer

const FILL: int = 0

func _ready() -> void:
	clear()

func paint_cells(tiles: Array[Vector2i]) -> void:
	for cell: Vector2i in tiles:
		set_cell(cell, 0, Vector2i(7, 4))
