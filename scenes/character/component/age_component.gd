class_name AgeComponent
extends Resource

signal age_changed(age: AgeData)

## Must be sorted in decreasing order
@export var ages: Array[AgeData] = []

var current_age: AgeData


func update(current_time: float) -> void:
	for age: AgeData in ages:
		if current_time >= age.min_time:
			if current_age != age:
				current_age = age
				age_changed.emit(age)
			return
