extends CharacterBody2D

const GROUND_SPEED = 2000.0
const AIR_SPEED = GROUND_SPEED * 0.5
const DRAG = 1500.0
const MAX_GROUND_SPEED = 250
const MAX_AIR_SPEED = 450
const JUMP_VELOCITY = -350.0
const controls = {
	'p1': {
		'UP': 'p1_up',
		'DOWN': 'p1_down',
		'LEFT': 'p1_left',
		'RIGHT': 'p1_right',
		'JUMP': 'p1_jump',
		'FIRE': 'p1_fire',
		'DUMP': 'p1_dump', 
	},
	'p2': {
		'UP': 'p2_up',
		'DOWN': 'p2_down',
		'LEFT': 'p2_left',
		'RIGHT': 'p2_right',
		'JUMP': 'p2_jump',
		'FIRE': 'p2_fire',
		'DUMP': 'p2_dump', 
	}
}

const sprites = {
	'p1': 'res://Assets/boi2.png',
	'p2': 'res://Assets/purp_boi2.png'
}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const BULLET_VELOCITY = 650
const bullet = preload('res://bullet.tscn')
const GENERIC_BUCKET = preload('res://GenericBucket.tscn')

var _velocity = Vector2()
var player_color: String
var health = 6
var is_dead = false
@export_enum('p1', 'p2') var player_num: String

var ammo = ''
var ammo_count = 0

func _ready():
	player_color = 'REDYELLOWRED' if player_num == 'p1' else 'REDBLUERED'
	$Sprite2D.texture = load(sprites[player_num])

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		_velocity.y += gravity * delta
	
	# Handle Dump.
	if Input.is_action_just_pressed(get_action(player_num, 'DUMP')) and ammo_count > 0:
		dump_ammo()
	
	# Handle Jump.
	if Input.is_action_just_pressed(get_action(player_num, 'JUMP')):
		var cwj = can_walljump()
		print(cwj)
		if is_on_floor() or cwj == 'BOTH':
			_velocity.y += JUMP_VELOCITY
		elif cwj == 'LEFT':
			_velocity.x += JUMP_VELOCITY * 0.8
			_velocity.y += JUMP_VELOCITY
		elif cwj == 'RIGHT':
			_velocity.x += JUMP_VELOCITY * -0.8
			_velocity.y += JUMP_VELOCITY
			
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis(get_action(player_num, 'LEFT'), get_action(player_num, 'RIGHT'))
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
	
	if Input.is_action_just_pressed(get_action(player_num, 'FIRE')):
		fire_projectile(ammo)
	# Apply the velocity changes
	velocity = _velocity
	move_and_slide()
	_velocity = velocity
	


func get_action(player_num, action):
	return controls[player_num][action]
	

func can_walljump():
	var leftHit = false
	var rightHit = false
	
	# Check if the left or right ray hits a vertical suface
	if $LeftRay.is_colliding():
		leftHit = abs($LeftRay.get_collision_normal().y) < 0.5 and abs($LeftRay.get_collision_normal().x) > 0.5
	if $RightRay.is_colliding():
		rightHit = abs($RightRay.get_collision_normal().y) < 0.5 and abs($RightRay.get_collision_normal().x) > 0.5
	
	if not is_on_floor():
		if leftHit and rightHit:
			return 'BOTH'  
		elif leftHit and not rightHit:
			return 'RIGHT'
		elif rightHit and not leftHit:
			return 'LEFT'
		
	return 'NONE'
	
func can_fire():
	return ammo_count >=2
	
func fire_projectile(color: String):
	if can_fire():
		var b = bullet.instantiate()
		b.setup(player_color, color)
		b.position = global_transform.origin + Vector2(0, -3.0)
		b.apply_impulse((Vector2.LEFT if $Sprite2D.flip_h else Vector2.RIGHT) * BULLET_VELOCITY)
		get_parent().add_child(b)
		ammo = ''
		ammo_count = 0
	change_hud(Global.color_textures[ammo])
	
func process_hit(color: String):
	print('%s hit by %s' % [player_color, color])
	health -= 1
	if color in player_color:
		health -= 1
	if health == 0:
		is_dead = true
		return
	get_parent().get_node('CanvasLayer/%sHealthIndicator' % player_num).display_health(health)

func spawn_bucket(position, color):
	var b = GENERIC_BUCKET.instantiate()
	b.color = color
	b.position = global_transform.origin
	b.get_node('SpawnTimer').wait_time = 2
	b.get_node('Timer').autostart = false
	b.dropped = true
	get_parent().add_child(b)
	pass
	
func change_hud(new_texture):
	get_parent().get_node('CanvasLayer/%sAmmo' % player_num).texture = new_texture
	
func empty_ammo():
	ammo = ''
	ammo_count = 0
	change_hud(Global.color_textures[ammo])
	
func dump_ammo():
	spawn_bucket(global_transform.origin, ammo)
	empty_ammo()

func fillBucket(color):
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
