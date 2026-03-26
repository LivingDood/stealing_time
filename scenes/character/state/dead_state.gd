class_name DeadState
extends PlayerState


func enter() -> void:
	_player.animation_player.play("death")
	_player.sprite.flip_h = not _player.direction_component.is_looking_right
