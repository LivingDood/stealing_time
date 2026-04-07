extends Control

@export var player: PlayerCharacter
@export var progress: ProgressBar


func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	progress.value = player.time_component.time
