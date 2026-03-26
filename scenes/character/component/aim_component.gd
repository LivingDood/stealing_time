class_name AimComponent
extends Resource

var target: Object

var _space_state: PhysicsDirectSpaceState2D


func initialize(tree: SceneTree) -> void:
	var world = tree.current_scene.get_viewport().find_world_2d()
	_space_state = world.direct_space_state


func update(mouse_position: Vector2) -> void:
	if _space_state:
		var query = PhysicsPointQueryParameters2D.new()
		query.position = mouse_position
		query.collide_with_bodies = true
		query.collide_with_areas = false
		
		var result = _space_state.intersect_point(query, 1)
		if result.is_empty():
			target = null
		else:
			target = result[0].collider
