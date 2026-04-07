class_name PlayerCharacter
extends CharacterBody2D

signal died

@export var can_act: bool = false

@export_group("Visuals")
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer
@export var age_transition_player: AnimationPlayer
@export var state_machine: PlayerStateMachine

@export_group("Inputs")
@export var input_component: InputComponent

@export_group("Movements")
@export var direction_component: DirectionComponent
@export var move_component: MoveComponent
@export var jump_component: JumpComponent

@export_group("Mechanics")
@export var aim_component: AimComponent
@export var steal_component: StealComponent
@export var time_component: TimeComponent

var is_alive: bool = true


func _ready() -> void:
	age_transition_player.play(&"age")
	age_transition_player.pause()
	
	aim_component.initialize(get_tree())
	time_component.time_depleted.connect(kill)
	
	state_machine.initialize(self)
	state_machine.change_state("idle")


func _physics_process(delta: float) -> void:
	if is_alive:
		input_component.update()
		direction_component.update(input_component.direction)
		
		if can_act:
			aim_component.update(get_global_mouse_position())
			steal_component.update(self, delta, input_component.steal_pressed, input_component.give_pressed)
			
			time_component.remove(delta)
			age_transition_player.advance(-delta)
	
	move_component.update(self, input_component.direction)
	jump_component.update(self, delta, input_component.jump_just_pressed)
	
	state_machine.update(delta)
	move_and_slide()


func set_time(time: float) -> void:
	time_component.set_time(time)
	age_transition_player.play(&"age")
	age_transition_player.pause()
	age_transition_player.advance(time)


func kill() -> void:
	input_component.clear()
	state_machine.change_state("dead")
	is_alive = false
	died.emit()
