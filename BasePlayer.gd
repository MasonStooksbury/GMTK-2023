extends CharacterBody2D

const GROUND_SPEED = 2000.0
const AIR_SPEED = GROUND_SPEED * 0.5
const DRAG = 1500.0
const MAX_GROUND_SPEED = 250
const MAX_AIR_SPEED = 450
const JUMP_VELOCITY = -350.0

var color_textures = {
	"BLUE": Global.half_blue,
	"BLUEBLUE": Global.full_blue,
	"BLUERED": Global.full_purple,
	"BLUEYELLOW": Global.full_green,
	"RED": Global.half_red,
	"REDRED": Global.full_red,
	"REDBLUE": Global.full_purple,
	"REDYELLOW": Global.full_orange,
	"YELLOW": Global.half_yellow,
	"YELLOWYELLOW": Global.full_yellow,
	"YELLOWRED": Global.full_orange,
	"YELLOWBLUE": Global.full_green,
	"": Global.empty
}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const BULLET_VELOCITY = 650
const bullet = preload('res://bullet.tscn')

var _velocity = Vector2()
var player_color: String
var health = 6
var is_dead = false

var ammo = ''
var ammo_count = 0

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
	pass
	
func process_hit(color: String):
	print('%s hit by %s' % [player_color, color])
	health -= 1
	if color == player_color:
		health -= 1
	if health == 0:
		is_dead = true
		return
