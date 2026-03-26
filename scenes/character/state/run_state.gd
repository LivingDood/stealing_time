class_name RunState
extends PlayerState


func enter() -> void:
	_player.animation_player.play("run")
	_player.sprite.flip_h = not _player.direction_component.is_looking_right


func update(_delta: float) -> void:
	_player.sprite.flip_h = not _player.direction_component.is_looking_right
	
	if _player.jump_component.is_falling:
		_player.state_machine.change_state("fall")
		return
	
	if not _player.move_component.is_moving:
		_player.state_machine.change_state("idle")
		return
	
	if _player.input_component.jump_just_pressed:
		_player.state_machine.change_state("jump")
		return
