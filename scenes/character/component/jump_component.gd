class_name JumpComponent
extends Resource

@export var jump_velocity: float = -480.0

var is_jumping: bool = false
var is_falling: bool = false
var has_just_landed: bool = false


func update(body: CharacterBody2D, delta:float, jump_just_pressed: bool) -> void:
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta
		is_jumping = false
		is_falling = true
		has_just_landed = false
	elif jump_just_pressed:
		body.velocity.y = jump_velocity
		is_jumping = true
		is_falling = false
		has_just_landed = false
	elif is_falling and not has_just_landed:
		is_jumping = false
		is_falling = false
		has_just_landed = true
	elif has_just_landed:
		is_jumping = false
		is_falling = false
		has_just_landed = false
