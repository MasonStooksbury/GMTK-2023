extends CharacterBody2D

@export_enum('Player1', 'Player2') var player_num: String

@onready var sprite = $Sprite2D
@onready var left_ray = $LeftRay
@onready var right_ray = $RightRay
@onready var wall_jump_timer = $WallJumpTimer


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const GROUND_SPEED = 2000.0
const AIR_SPEED = GROUND_SPEED * 0.5
const DRAG = 1500.0
const MAX_GROUND_SPEED = 250
const MAX_AIR_SPEED = 450
const JUMP_VELOCITY = -350.0
const BULLET_VELOCITY = 650
var was_wall_normal = Vector2.ZERO
var _velocity = Vector2()
var player_color: String
var health = 6
var ammo = ''
var ammo_count = 0
var is_dead = false
var squash_max = 1.25
var squash_min = 0.75
var jumped = false
var just_wall_jumped = false

const controls = {
	'Player1': {
		'UP': 'p1_up',
		'DOWN': 'p1_down',
		'LEFT': 'p1_left',
		'RIGHT': 'p1_right',
		'JUMP': 'p1_jump',
		'FIRE': 'p1_fire',
		'DUMP': 'p1_dump',
	},
	'Player2': {
		'UP': 'p2_up',
		'DOWN': 'p2_down',
		'LEFT': 'p2_left',
		'RIGHT': 'p2_right',
		'JUMP': 'p2_jump',
		'FIRE': 'p2_fire',
		'DUMP': 'p2_dump',
	}
}



func _ready():
	self.player_color = 'REDYELLOWRED' if player_num == 'Player1' else 'REDBLUERED'
	sprite.texture = Global.players[player_num]['texture']
	if get_parent().name != 'HowTo':
		spawn_at_random_position()



func _physics_process(delta):
	if Input.is_action_just_pressed('quit'):
		get_tree().change_scene_to_packed(Global.TITLESCREEN_SCENE)
	# Add the gravity.
	if not is_on_floor():
		_velocity.y += gravity * delta

	# Handle Jump.
	if is_on_floor():
		squash_and_stretch(Vector2(1, 1))
		if jumped:
			squash_and_stretch(Vector2(squash_max, squash_min))
			jumped = false
		if Input.is_action_just_pressed(get_action(player_num, 'JUMP')):
			_velocity.y += JUMP_VELOCITY
	else:
		squash_and_stretch(Vector2(squash_min, squash_max))

	if is_on_wall_only() and (Input.is_action_pressed(get_action(player_num, 'LEFT')) or Input.is_action_pressed(get_action(player_num, 'RIGHT'))):
		_velocity.y -= 3000 * delta

	# Handle Dump.
	if Input.is_action_just_pressed(get_action(player_num, 'DUMP')) and ammo_count > 0:
		dump_ammo()

	if Input.is_action_just_released(get_action(player_num, 'JUMP')):
		if _velocity.y < -100:
			_velocity.y = -100

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis(get_action(player_num, 'LEFT'), get_action(player_num, 'RIGHT'))
	var intensity = GROUND_SPEED if is_on_floor() else AIR_SPEED

	if direction:
		_velocity.x += direction * intensity * delta
		if direction > 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
	else:
		_velocity.x = move_toward(_velocity.x, 0, DRAG * delta)
	_velocity.x = clamp(_velocity.x, -MAX_GROUND_SPEED, MAX_GROUND_SPEED)
	_velocity.y = clamp(_velocity.y,  -MAX_AIR_SPEED, MAX_AIR_SPEED)

	if Input.is_action_just_pressed(get_action(player_num, 'FIRE')) and can_fire():
		fire_projectile(ammo)
	# Apply the velocity changes
	velocity = _velocity
	move_and_slide()
	_velocity = velocity



func squash_and_stretch(new_scale):
	sprite.scale = lerp(sprite.scale, new_scale, 0.4)



func fell_in_fray():
	health -= 1
	if health == 0:
		killPlayer()
		return
	get_parent().get_node('HUD/%sHealthIndicator' % player_num).display_health(health)
	empty_ammo()
	spawn_furthest_from_opponent()



func spawn_furthest_from_opponent():
	global_transform.origin = get_parent().get_furthest_spawn_point_position(player_num)




func spawn_at_random_position():
	var player_spawn_array = get_parent().get_node('PlayerSpawnOptions').get_children()
	var random_spawn = player_spawn_array[randi() % player_spawn_array.size()]
	global_transform.origin = random_spawn.global_transform.origin



func empty_ammo():
	ammo = ''
	ammo_count = 0
	change_ammo_meter_texture(Global.empty_ammo)



func get_action(player, action):
	return controls[player][action]



func can_fire():
	return ammo_count >= 2



func fire_projectile(color: String):
	var b = Global.BULLET_SCENE.instantiate()
	b.setup(self.player_color, color)
	b.position = global_transform.origin + Vector2(0, -3.0)
	b.apply_impulse((Vector2.LEFT if sprite.flip_h else Vector2.RIGHT) * BULLET_VELOCITY)
	get_parent().add_child(b)
	empty_ammo()



func process_hit(color: String):
	health -= 1
	if color in self.player_color:
		health -= 1
	if health <= 0:
		killPlayer()
		return
	get_parent().get_node('HUD/%sHealthIndicator' % player_num).display_health(health)



func spawn_bucket(pos, color):
	var b = Global.GENERIC_BUCKET_SCENE.instantiate()
	b.color = color
	b.position = pos
	b.get_node('SpawnTimer').wait_time = 2
	b.get_node('ColorChangeTimer').autostart = false
	b.dropped = true
	get_parent().add_child(b)
	pass



func change_ammo_meter_texture(new_texture):
	get_parent().get_node('HUD/%sAmmo' % player_num).texture = new_texture



func dump_ammo():
	spawn_bucket(global_transform.origin, ammo)
	empty_ammo()



# Called by Bullet scene
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

	change_ammo_meter_texture(Global.ammo_meter_textures[ammo])
	return false



func killPlayer():
	self.is_dead = true
	Global.players[player_num].is_dead = self.is_dead
