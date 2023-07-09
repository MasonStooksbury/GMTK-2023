extends "res://BasePlayer.gd"

func _ready():
	empty_ammo()
	player_color = 'ORANGE'

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		_velocity.y += gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("p1_jump") and is_on_floor():
		_velocity.y += JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("p1_left", "p1_right")
	var intensity = GROUND_SPEED if is_on_floor() else AIR_SPEED
	
	if direction:
		_velocity.x += direction * intensity * delta
		if direction > 0:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
	else:
		_velocity.x = move_toward(_velocity.x, 0, DRAG * delta)	
	_velocity.x = clamp(_velocity.x, -MAX_GROUND_SPEED, MAX_GROUND_SPEED)
	_velocity.y = clamp(_velocity.y,  -MAX_AIR_SPEED, MAX_AIR_SPEED)
	
	if Input.is_action_just_pressed("p1_fire"):
		fire_projectile()
	# Apply the velocity changes
	velocity = _velocity
	move_and_slide()

func fillBucket(color):
	change_hud(determine_new_texture(color, ammo))
	ammo += 1

func change_hud(new_texture):
	get_parent().get_node('CanvasLayer/P1Ammo').texture = new_texture
	
func empty_ammo():
	change_hud(Global.empty)
	_velocity = velocity
		
