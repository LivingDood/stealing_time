class_name DirectionComponent
extends Resource

@export var is_looking_right: bool = true


func update(direction: float) -> void:
	if direction > 0.0:
		is_looking_right = true
	elif direction < 0.0:
		is_looking_right = false
