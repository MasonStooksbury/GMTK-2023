extends Node

# SCENES
const BULLET_SCENE = preload('res://Bullet.tscn')
const GENERIC_BUCKET_SCENE = preload('res://GenericBucket.tscn')
const TITLESCREEN_SCENE = preload('res://Shared/TitleScreen/TitleScreen.tscn')
const ENDSCREEN_SCENE = preload('res://Shared/EndScreen.tscn')

var empty:CompressedTexture2D = load("res://Assets/ammo_meter_empty.png")
var half_blue:CompressedTexture2D = load("res://Assets/ammo_meter_half_blue.png")
var full_blue:CompressedTexture2D = load("res://Assets/ammo_meter_full_blue.png")
var half_red:CompressedTexture2D = load("res://Assets/ammo_meter_half_red.png")
var full_red:CompressedTexture2D = load("res://Assets/ammo_meter_full_red.png")
var half_yellow:CompressedTexture2D = load("res://Assets/ammo_meter_half_yellow.png")
var full_yellow:CompressedTexture2D = load("res://Assets/ammo_meter_full_yellow.png")

var full_purple:CompressedTexture2D = load("res://Assets/ammo_meter_full_purple.png")
var full_orange:CompressedTexture2D = load("res://Assets/ammo_meter_full_orange.png")
var full_green:CompressedTexture2D = load("res://Assets/ammo_meter_full_green.png")

var blue_blob:CompressedTexture2D = load("res://Assets/blob_blue.png")
var red_blob:CompressedTexture2D = load("res://Assets/blob_red.png")
var green_blob:CompressedTexture2D = load("res://Assets/blob_green.png")
var yellow_blob:CompressedTexture2D = load("res://Assets/blob_yellow.png")
var orange_blob:CompressedTexture2D = load("res://Assets/blob_orange.png")
var purple_blob:CompressedTexture2D = load("res://Assets/blob_purple.png")

var blue_bucket:CompressedTexture2D = load("res://Assets/bucket_blue.png")
var red_bucket:CompressedTexture2D = load("res://Assets/bucket_red.png")
var green_bucket:CompressedTexture2D = load("res://Assets/bucket_green.png")
var yellow_bucket:CompressedTexture2D = load("res://Assets/bucket_yellow.png")
var orange_bucket:CompressedTexture2D = load("res://Assets/bucket_orange.png")
var purple_bucket:CompressedTexture2D = load("res://Assets/bucket_purple.png")


var color_textures = {
	"BLUE": half_blue,
	"BLUEBLUE": full_blue,
	"BLUERED": full_purple,
	"BLUEYELLOW": full_green,
	"RED": half_red,
	"REDRED": full_red,
	"REDBLUE": full_purple,
	"REDYELLOW": full_orange,
	"YELLOW": half_yellow,
	"YELLOWYELLOW": full_yellow,
	"YELLOWRED": full_orange,
	"YELLOWBLUE": full_green,
	"": empty
}

var blob_textures = {
	"BLUE": blue_blob,
	"BLUEBLUE": blue_blob,
	"BLUERED": purple_blob,
	"BLUEYELLOW": green_blob,
	"RED": red_blob,
	"REDRED": red_blob,
	"REDBLUE": purple_blob,
	"REDYELLOW": orange_blob,
	"YELLOW": yellow_blob,
	"YELLOWYELLOW": yellow_blob,
	"YELLOWRED": orange_blob,
	"YELLOWBLUE": green_blob
}

var bucket_textures = {
	"BLUE": blue_bucket,
	"BLUEBLUE": blue_bucket,
	"BLUERED": purple_bucket,
	"BLUEYELLOW": green_bucket,
	"RED": red_bucket,
	"REDRED": red_bucket,
	"REDBLUE": purple_bucket,
	"REDYELLOW": orange_bucket,
	"YELLOW": yellow_bucket,
	"YELLOWYELLOW": yellow_bucket,
	"YELLOWRED": orange_bucket,
	"YELLOWBLUE": green_bucket
}

var primary_colors = ['RED', 'BLUE', 'YELLOW']
var complex_colors = ["BLUEBLUE", "BLUERED", "BLUEYELLOW", "REDRED", "REDBLUE", "REDYELLOW", "YELLOWYELLOW", "YELLOWRED", "YELLOWBLUE"]
var deduped_complex_colors = ["BLUEBLUE", "REDRED", "YELLOWYELLOW", "REDBLUE", "REDYELLOW", "YELLOWBLUE"]
