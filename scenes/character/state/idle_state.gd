class_name IdleState
extends PlayerState


func enter() -> void:
	_player.animation_player.play("idle")
	_player.sprite.flip_h = not _player.direction_component.is_looking_right


func update(_delta: float) -> void:
	if _player.jump_component.is_falling:
		_player.state_machine.change_state("fall")
		return
	
	if _player.move_component.is_moving:
		_player.state_machine.change_state("run")
		return
	
	if _player.input_component.jump_just_pressed:
		_player.state_machine.change_state("jump")
		return
