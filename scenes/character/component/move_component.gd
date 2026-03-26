class_name MoveComponent
extends Resource

@export var move_speed: float = 320.0

var is_moving: bool = false


func update(body: CharacterBody2D, direction: float) -> void:
	if direction:
		body.velocity.x = direction * move_speed
	else:
		body.velocity.x = move_toward(body.velocity.x, 0, move_speed)
	
	is_moving = body.velocity.x != 0.0
