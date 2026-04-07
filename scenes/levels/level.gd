class_name Level
extends Node

@export var level_id: int = 0
@export var next_level_id: int = 0
@export var next_level_path: String

@export var initial_timer: float = 60.0

@export var animation_player: AnimationPlayer
@export var exit_area: Area2D
@export var traps: Array[Area2D]

@export var player: PlayerCharacter
@export var mobile_controls: Control


func _ready() -> void:
	player.can_act = false
	
	exit_area.body_entered.connect(_on_exit_area_entered)
	if traps:
		for trap in traps:
			trap.body_entered.connect(_on_traps_entered)
	
	await SceneManager.transition_finished
	
	if(animation_player.has_animation(&"intro")):
		animation_player.play(&"intro")
		await animation_player.animation_finished
	
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		mobile_controls.show()
	else:
		mobile_controls.hide()
	
	player.set_time(initial_timer)
	player.can_act = true


func go_to_next_level() -> void:
	ParticleManager.remove_all()
	AudioManager.stop_all_sfx()
	SceneManager.change_scene(next_level_path, "slide_up")


func _on_exit_area_entered(_body: Node2D) -> void:
	player.can_act = false
	SaveManager.unlock_level(next_level_id)
	go_to_next_level()


func _on_traps_entered(body: Node2D) -> void:
	if body == player:
		player.kill()
