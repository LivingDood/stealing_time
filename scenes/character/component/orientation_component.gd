class_name OrientationComponent
extends Resource

#The rotated directions referring to up,down,left,right
var up:Vector2 = Vector2.UP
var down:Vector2 = Vector2.DOWN
var left:Vector2 = Vector2.LEFT
var right:Vector2 = Vector2.RIGHT
var rotation:float = 0.
#rows of the rotation matrix.
var row1:Vector2 = Vector2(1,0)
var row2:Vector2 = Vector2(0,1)
var _velocity = Vector2(0,0)
var local_velocity:Vector2:
	get:return _velocity
	set(val):_velocity = val
var body_velocity:Vector2:
	get:return to_body(_velocity)
	set(val): _velocity = to_local(val)
var gravity:Vector2 = Vector2.DOWN*980

func to_local(vec:Vector2) ->Vector2:
	return Vector2(vec.dot(row1),vec.dot(row2))

func to_body(vec:Vector2) ->Vector2:
	var reversed:Vector2 = Vector2(vec.y,vec.x)
	return Vector2(row2.dot(reversed),row1.dot(reversed))

func update(body:CharacterBody2D):
	var new_gravity:Vector2 = body.get_gravity()
	if(new_gravity != gravity && new_gravity != Vector2.ZERO):
		gravity = new_gravity
		body.up_direction = -gravity.normalized()
		rotation = Vector2.DOWN.angle_to(gravity)
		body.rotation = rotation
		var cos_rot:float = cos(rotation)
		var sin_rot:float = sin(rotation)
		#rows in the would-be rotation matrix
		row1 = Vector2(cos_rot,-sin_rot)
		row2 = Vector2(sin_rot,cos_rot)
		#Use the precomputed values, so the rotate function
		#doesn't have to recompute sin and cosine of theta,
		#Since the direction vectors are unit vectors with 0
		#as one component, we can also ignore certain components
		#while doing the rotation
		up = Vector2(sin_rot,-cos_rot)
		down = Vector2(-sin_rot,cos_rot)
		
		left = Vector2(-cos_rot,-sin_rot)
		right = Vector2(cos_rot,sin_rot)
	body_velocity = body.velocity
