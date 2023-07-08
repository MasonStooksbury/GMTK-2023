extends RigidBody2D

const GROUND_SPEED = 2000.0
const AIR_SPEED = GROUND_SPEED * 0.5
const DRAG = 1500.0
const MAX_GROUND_SPEED = 250
const MAX_AIR_SPEED = 400
const JUMP_VELOCITY = -350.0
var _velocity = Vector2()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func doStuff():
	print('wee')
