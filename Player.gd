extends "res://BasePlayer.gd"

func _ready():
	empty_ammo()
	player_color = 'REDYELLOWRED'


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		_velocity.y += gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("p1_jump") and is_on_floor():
		_velocity.y += JUMP_VELOCITY
		
	# Handle Dump.
	if Input.is_action_just_pressed("p1_dump") and ammo_count > 0:
		dump_ammo()
		
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
		fire_projectile(ammo)
	# Apply the velocity changes
	velocity = _velocity
	move_and_slide()
	_velocity = velocity


func fillBucket(color):
	# ammo full, return
	# <= 1, hit primary color
	#	ammo += color
	#	ammount_count += 1
	if ammo_count == 2:
		return true
	if (ammo_count <= 1 and color in ['RED', 'BLUE', 'YELLOW']):
		ammo += color
		ammo_count += 1
	elif (ammo_count == 0 and color not in ['RED', 'BLUE', 'YELLOW']):
		ammo += color
		ammo_count += 2
	else:
		return true
	
	
	change_hud(Global.color_textures[ammo])
	return false

func change_hud(new_texture):
	get_parent().get_node('CanvasLayer/P1Ammo').texture = new_texture
	
func empty_ammo():
	ammo = ''
	ammo_count = 0
	change_hud(Global.color_textures[ammo])
	
func dump_ammo():
	#spawn a bucket of ammo color
	spawn_bucket(global_transform.origin, ammo)
	empty_ammo()


func process_hit(color: String):
	super.process_hit(color)
	get_parent().get_node('CanvasLayer/P1HealthIndicator').display_health(health)
	
func fire_projectile(color: String):
	super.fire_projectile(ammo)
	change_hud(Global.color_textures[ammo])
