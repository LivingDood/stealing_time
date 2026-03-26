class_name PlayerCharacter
extends CharacterBody2D

signal died

@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer

@export var input_component: InputComponent
@export var direction_component: DirectionComponent
@export var move_component: MoveComponent
@export var jump_component: JumpComponent

@export var aim_component: AimComponent
@export var steal_component: StealComponent

@export var age_component: AgeComponent
@export var time_component: TimeComponent

@export var state_machine: PlayerStateMachine

var can_act: bool = false
var is_dead: bool = false


func _ready() -> void:
	aim_component.initialize(get_tree())
	
	age_component.age_changed.connect(_on_age_changed)
	age_component.update(time_component.time)
	
	time_component.time_depleted.connect(kill)
	
	state_machine.initialize(self)
	state_machine.change_state("idle")


func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	input_component.update()
	direction_component.update(input_component.direction)
	move_component.update(self, input_component.direction)
	jump_component.update(self, delta, input_component.jump_just_pressed)
	
	aim_component.update(get_global_mouse_position())
	steal_component.update(self, delta)
	
	time_component.remove(delta)
	age_component.update(time_component.time)
	
	state_machine.update(delta)
	move_and_slide()


func kill() -> void:
	state_machine.change_state("dead")
	is_dead = true
	died.emit()


func _on_age_changed(age: AgeData) -> void:
	sprite.texture = age.texture
