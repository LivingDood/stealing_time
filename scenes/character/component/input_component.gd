class_name InputComponent
extends Resource

@export var left_action: StringName
@export var right_action: StringName
@export var jump_action: StringName

@export var steal_action: StringName
@export var give_action: StringName

var direction: float
var jump_pressed: bool = false
var jump_just_pressed: bool = false
var jump_just_released: bool = false

var steal_pressed: bool = false
var give_pressed: bool = false


func update() -> void:
	direction = Input.get_axis(left_action, right_action)
	jump_pressed = Input.is_action_pressed(jump_action)
	jump_just_pressed = Input.is_action_just_pressed(jump_action)
	jump_just_released = Input.is_action_just_released(jump_action)
	
	steal_pressed = Input.is_action_pressed(steal_action)
	give_pressed = Input.is_action_pressed(give_action)
