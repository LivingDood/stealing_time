@abstract
class_name Stealable
extends AnimatableBody2D

@export var marker: Marker2D

var time_transfer_multiplier: float = 1.0


@abstract
func steal(seconds: float) -> float


@abstract
func give(seconds: float) -> float


@abstract
func set_outline(enabled: bool) -> void
