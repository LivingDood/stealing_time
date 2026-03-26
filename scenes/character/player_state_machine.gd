class_name PlayerStateMachine
extends Resource

@export var state_map: Dictionary[StringName, PlayerState] = {}

var _player: PlayerCharacter
var _current_state_name: StringName
var _current_state: PlayerState


func initialize(player: PlayerCharacter) -> void:
	_player = player
	for state: PlayerState in state_map.values():
		state.initialize(_player)


func update(delta: float) -> void:
	if _current_state:
		_current_state.update(delta)


func change_state(state_name: StringName) -> void:
	if state_name not in state_map or state_name == _current_state_name:
		return
	
	if _current_state:
		_current_state.exit()
	
	_current_state_name = state_name
	_current_state = state_map[_current_state_name]
	_current_state.enter()
