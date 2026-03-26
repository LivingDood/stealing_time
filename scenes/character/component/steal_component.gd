class_name StealComponent
extends Resource

@export var steal_sfx: AudioStream
@export var give_sfx: AudioStream

var target: Stealable


func update(player: PlayerCharacter, delta: float) -> void:
	if player.aim_component.target is Stealable:
		var new_target = player.aim_component.target
		if new_target != target:
			if target:
				target.set_highlight(false)
		target = new_target
	elif target:
		target.set_highlight(false)
		target = null
	
	if target:
		target.set_highlight(true)
		if player.input_component.steal_pressed:
			if target.steal(delta) > 0.0:
				player.time_component.add(delta)
				ParticleManager.generate(target.global_position, player, steal_sfx)
		elif player.input_component.give_pressed:
			if target.give(delta) > 0.0:
				player.time_component.remove(delta)
				ParticleManager.generate(player.global_position, target, give_sfx)
