class_name JumpComponent
extends Resource

@export var jump_velocity: float = -960.0
@export var coyote_time: float = 0.1
@export var fall_gravity_multiplier: float = 3.0

var is_jumping: bool = false
var is_falling: bool = false
var has_just_landed: bool = false

var coyote_timer: float = 0.0


func update(body: CharacterBody2D, delta:float, is_jump_just_pressed: bool) -> void:
	if body.is_on_floor():
		has_just_landed = is_falling
		is_jumping = false
		is_falling = false
		coyote_timer = coyote_time
	else:
		body.velocity += body.get_gravity() * delta * fall_gravity_multiplier
		if coyote_timer <= 0.0:
			is_jumping = false
			is_falling = true
			has_just_landed = false
		else:
			coyote_timer -= delta
	
	if is_jump_just_pressed and coyote_timer > 0.0:
		body.velocity.y = jump_velocity
		is_jumping = true
		is_falling = false
		has_just_landed = false
		coyote_timer = 0.0
