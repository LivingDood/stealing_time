class_name StealComponent
extends Resource

@export var steal_sfx: AudioStream
@export var give_sfx: AudioStream

var target: Stealable


func update(player: PlayerCharacter, delta: float, is_steal_pressed: bool, is_give_pressed: bool) -> void:
	var selected:Object = player.aim_component.target
	if target:
		target.set_outline(true)
		if is_steal_pressed:
			if target.steal(delta) > 0.0:
				player.time_component.add(delta)
				ParticleManager.generate(target.marker.global_position, player, steal_sfx)
				selected = target
		elif is_give_pressed:
			if target.give(delta) > 0.0:
				player.time_component.remove(delta)
				ParticleManager.generate(player.global_position, target.marker, give_sfx)
				selected = target
		if(selected != target):
			target.set_outline(false)
			if(selected is Stealable):
				selected.set_outline(true)
				target = selected
	else:
		if selected is Stealable:
			target = selected
			target.set_outline(true)
		
				
