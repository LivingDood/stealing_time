class_name FallState
extends PlayerState


func enter() -> void:
	_player.animation_player.play("fall")
	_player.sprite.flip_h = not _player.direction_component.is_looking_right


func update(_delta: float) -> void:
	_player.sprite.flip_h = not _player.direction_component.is_looking_right
	
	if _player.jump_component.has_just_landed:
		_player.state_machine.change_state("land")
		return
