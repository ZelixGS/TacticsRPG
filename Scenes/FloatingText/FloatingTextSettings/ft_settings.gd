class_name FTSettings extends RefCounted

const DEFAULT_UP: Vector2 = Vector2(0, -40)

var travel: Vector2
var duration: float
var spread: float
var emphasized: bool
var transition: Tween.TransitionType
var easing: Tween.EaseType

func _init(travel_: Vector2 = DEFAULT_UP, duration_: float = 2.5,
		   spread_: float = PI/2, emphasized_: bool = false,
		   transition_: Tween.TransitionType = Tween.TransitionType.TRANS_LINEAR,
		   easing_: Tween.EaseType = Tween.EaseType.EASE_OUT) -> void:
	travel = travel_
	duration = duration_
	spread = spread_
	emphasized = emphasized_
	transition = transition_
	easing = easing_
