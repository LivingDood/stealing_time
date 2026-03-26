class_name JumpState
extends PlayerState

var animation_finished: bool = false


func enter() -> void:
	animation_finished = false
	_player.animation_player.play("jump")
	if not _player.animation_player.animation_finished.is_connected(_on_animation_finished):
		_player.animation_player.animation_finished.connect(_on_animation_finished)
	_player.sprite.flip_h = not _player.direction_component.is_looking_right


func exit() -> void:
	animation_finished = false
	if _player.animation_player.animation_finished.is_connected(_on_animation_finished):
		_player.animation_player.animation_finished.disconnect(_on_animation_finished)


func update(_delta: float) -> void:
	_player.sprite.flip_h = not _player.direction_component.is_looking_right
	
	if animation_finished and _player.jump_component.is_falling:
		_player.state_machine.change_state("fall")
		return
	
	if _player.jump_component.has_just_landed:
		_player.state_machine.change_state("land")
		return


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name != "jump":
		return
	
	animation_finished = true
