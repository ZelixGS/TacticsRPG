class_name Faction extends RefCounted

enum FACTION { FRIENDLY, ENEMY, NEUTRAL }

static func is_friendly(a: FACTION, b: FACTION) -> bool:
	return a == b

static func is_hostile(a: FACTION, b: FACTION) -> bool:
	return a != b
