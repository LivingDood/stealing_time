class_name TimeComponent
extends Resource

signal time_depleted

@export var time: float = 0.0


func set_time(seconds: float) -> void:
	var previous_time: float = time
	time = max(0.0, seconds)
	
	if previous_time > 0.0 and time == 0.0:
		time_depleted.emit()


func add(seconds: float) -> void:
	time += seconds


func remove(seconds: float) -> void:
	var previous_time: float = time
	time = max(0.0, time - seconds)
	
	if previous_time > 0.0 and time == 0.0:
		time_depleted.emit()
