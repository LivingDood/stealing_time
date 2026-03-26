@abstract
class_name PlayerState
extends Resource

var _player: PlayerCharacter


func initialize(player: PlayerCharacter) -> void:
	_player = player


func enter() -> void:
	pass


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass
