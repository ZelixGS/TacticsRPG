extends Camera2D

@export var screen_size: Vector2 = Vector2(908, 432)
@export var speed: float = 160.0

var is_zooming: bool = false

func _process(delta: float) -> void:
	move_camera(delta)

func get_input() -> Vector2:
		return Input.get_vector("camera_move_left", "camera_move_right", "camera_move_up", "camera_move_down")

func move_camera(delta: float) -> void:
	global_position += get_input() * speed * delta
	global_position = global_position.snapped(Vector2(1, 1))
	global_position = global_position.clamp(Vector2.ZERO, screen_size)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("camera_zoom_in"):
		zoom_camera(zoom * 2)
	if event.is_action_pressed("camera_zoom_out"):
		zoom_camera(zoom / 2)

func zoom_camera(final_value: Vector2, duration: float = 0.2) -> void:
	if is_zooming:
		return
	is_zooming = true
	var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "zoom", final_value, duration)
	await tween.finished
	is_zooming = false
