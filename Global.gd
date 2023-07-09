extends Node

var test = 'test'

var empty:CompressedTexture2D = load("res://Assets/ammo_meter_empty.png")
var half_blue:CompressedTexture2D = load("res://Assets/ammo_meter_half_blue.png")
var full_blue:CompressedTexture2D = load("res://Assets/ammo_meter_full_blue.png")
var half_red:CompressedTexture2D = load("res://Assets/ammo_meter_half_red.png")
var full_red:CompressedTexture2D = load("res://Assets/ammo_meter_full_red.png")
var full_purple:CompressedTexture2D = load("res://Assets/ammo_meter_full_purple.png")

var color_textures = {
	"BLUE": half_blue,
	"BLUEBLUE": full_blue,
	"RED": half_red,
	"REDRED": full_red,
	"REDBLUE": full_purple,
	"BLUERED": full_purple
}
var half_yellow:CompressedTexture2D = load("res://Assets/ammo_meter_half_yellow.png")
var full_yellow:CompressedTexture2D = load("res://Assets/ammo_meter_full_yellow.png")

var full_purple:CompressedTexture2D = load("res://Assets/ammo_meter_full_purple.png")
var full_orange:CompressedTexture2D = load("res://Assets/ammo_meter_full_orange.png")
var full_green:CompressedTexture2D = load("res://Assets/ammo_meter_full_green.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

