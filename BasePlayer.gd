extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -350.0
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
