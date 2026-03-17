class_name Level
extends Node

@export var level_id: int = 0
@export var next_level_id: int = 0
@export var next_level_path: String

@export var animation_player: AnimationPlayer


func _ready() -> void:
	await SceneManager.transition_finished


func _on_level_finished() -> void:
	SaveManager.unlock_level(level_id)
	SceneManager.change_scene(next_level_path)
