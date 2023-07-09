extends CharacterBody2D

const GROUND_SPEED = 2000.0
const AIR_SPEED = GROUND_SPEED * 0.5
const DRAG = 1500.0
const MAX_GROUND_SPEED = 250
const MAX_AIR_SPEED = 450
const JUMP_VELOCITY = -350.0
<<<<<<< HEAD
# 0 is empty
# 1 is half
# 2 is full
var ammo = 0

#var color_textures = {
#	"BLUE": [Global.half_blue, Global.full_blue],
#	"RED": [Global.half_red, Global.full_red]
#}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#func determine_new_texture(color, ammo):
##	var new_texture
#
##	if ammo == 0:
##		if color == 'BLUE':
##			new_texture = Global.half_blue
##		elif color == 'RED':
##			new_texture = Global.half_red
##	elif ammo == 1:
##		if color == 'BLUE':
##			new_texture = Global.full_blue
##		elif color == 'RED':
##			new_texture = Global.full_red
#
#	return color_textures[color][ammo]
#	#return new_texture
=======
const BULLET_VELOCITY = 650
const bullet = preload('res://bullet.tscn')

var _velocity = Vector2()
var player_color: String
var health = 6
var ammo = PackedStringArray()



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func doStuff():
	print('wee')

func can_fire():
	return ammo.size() >=2
	
func dump_ammo():
	if not ammo.is_empty():
		ammo.remove_at(ammo.size() -1)
		
func fire_projectile():
	if can_fire():
		var b = bullet.instantiate()
		b.setup(player_color, 'RED')
		b.position = global_transform.origin + Vector2(0, -3.0)
		b.apply_impulse((Vector2.LEFT if $Sprite2D.flip_h else Vector2.RIGHT) * BULLET_VELOCITY)
		get_parent().add_child(b)
	
	pass
	
func process_hit(color: String):
	print('%s hit by %s' % [player_color, color])
	health -= 1
	if color == player_color:
		health -= 1
>>>>>>> 7c510d3c0414b68524971ac09f0c7cea4719ffc3
