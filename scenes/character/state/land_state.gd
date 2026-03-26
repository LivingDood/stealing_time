class_name LandState
extends PlayerState


func enter() -> void:
	_player.animation_player.play("land")
	if not _player.animation_player.animation_finished.is_connected(_on_animation_finished):
		_player.animation_player.animation_finished.connect(_on_animation_finished)


func exit() -> void:
	if _player.animation_player.animation_finished.is_connected(_on_animation_finished):
		_player.animation_player.animation_finished.disconnect(_on_animation_finished)


func update(_delta: float) -> void:
	_player.sprite.flip_h = not _player.direction_component.is_looking_right
	
	if _player.input_component.jump_just_pressed:
		_player.state_machine.change_state("jump")
		return


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name != "land":
		return
	
	if _player.move_component.is_moving:
		_player.state_machine.change_state("run")
	else:
		_player.state_machine.change_state("idle")
