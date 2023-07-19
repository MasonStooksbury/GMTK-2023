extends Node

# SCENES
const BULLET_SCENE = preload('res://bullet.tscn')
const GENERIC_BUCKET_SCENE = preload('res://GenericBucket.tscn')
const TITLESCREEN_SCENE = preload('res://Screens/TitleScreen.tscn')
const ENDSCREEN_SCENE = preload('res://Screens/EndScreen.tscn')

# PLAYERS
var players = {
	'Player1': {
		'texture': preload('res://Assets/player/boi2.png'),
		'name': 'Player 1',
		'is_dead': false
	},
	'Player2': {
		'texture': preload('res://Assets/player/purp_boi2.png'),
		'name': 'Player 2',
		'is_dead': false
	}
}

# AMMO METER
var empty_ammo:CompressedTexture2D = preload("res://Assets/ammo_meter/ammo_meter_empty.png")
var half_blue_ammo:CompressedTexture2D = preload("res://Assets/ammo_meter/ammo_meter_half_blue.png")
var full_blue_ammo:CompressedTexture2D = preload("res://Assets/ammo_meter/ammo_meter_full_blue.png")
var half_red_ammo:CompressedTexture2D = preload("res://Assets/ammo_meter/ammo_meter_half_red.png")
var full_red_ammo:CompressedTexture2D = preload("res://Assets/ammo_meter/ammo_meter_full_red.png")
var half_yellow_ammo:CompressedTexture2D = preload("res://Assets/ammo_meter/ammo_meter_half_yellow.png")
var full_yellow_ammo:CompressedTexture2D = preload("res://Assets/ammo_meter/ammo_meter_full_yellow.png")
var full_purple_ammo:CompressedTexture2D = preload("res://Assets/ammo_meter/ammo_meter_full_purple.png")
var full_orange_ammo:CompressedTexture2D = preload("res://Assets/ammo_meter/ammo_meter_full_orange.png")
var full_green_ammo:CompressedTexture2D = preload("res://Assets/ammo_meter/ammo_meter_full_green.png")

# BULLETS
var blue_blob:CompressedTexture2D = preload("res://Assets/blob/blob_blue.png")
var red_blob:CompressedTexture2D = preload("res://Assets/blob/blob_red.png")
var green_blob:CompressedTexture2D = preload("res://Assets/blob/blob_green.png")
var yellow_blob:CompressedTexture2D = preload("res://Assets/blob/blob_yellow.png")
var orange_blob:CompressedTexture2D = preload("res://Assets/blob/blob_orange.png")
var purple_blob:CompressedTexture2D = preload("res://Assets/blob/blob_purple.png")

# BUCKETS
var blue_bucket:CompressedTexture2D = preload("res://Assets/bucket/bucket_blue.png")
var red_bucket:CompressedTexture2D = preload("res://Assets/bucket/bucket_red.png")
var green_bucket:CompressedTexture2D = preload("res://Assets/bucket/bucket_green.png")
var yellow_bucket:CompressedTexture2D = preload("res://Assets/bucket/bucket_yellow.png")
var orange_bucket:CompressedTexture2D = preload("res://Assets/bucket/bucket_orange.png")
var purple_bucket:CompressedTexture2D = preload("res://Assets/bucket/bucket_purple.png")

# Dictionary with all the ammo meter textures
var ammo_meter_textures = {
	"BLUE": half_blue_ammo,
	"BLUEBLUE": full_blue_ammo,
	"BLUERED": full_purple_ammo,
	"BLUEYELLOW": full_green_ammo,
	"RED": half_red_ammo,
	"REDRED": full_red_ammo,
	"REDBLUE": full_purple_ammo,
	"REDYELLOW": full_orange_ammo,
	"YELLOW": half_yellow_ammo,
	"YELLOWYELLOW": full_yellow_ammo,
	"YELLOWRED": full_orange_ammo,
	"YELLOWBLUE": full_green_ammo,
	"": empty_ammo
}

# Dictionary with all the bullet textures
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

# Dictionary with all the bucket textures
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

var color_vals = {
	"BLUEBLUE": 0x5c6bc0ff,
	"BLUERED": 0x9c27b0ff,
	"BLUEYELLOW": 0x0a8f08ff,
	"REDRED": 0xe84e40ff,
	"REDBLUE": 0x9c27b0ff,
	"REDYELLOW": 0xfb8c00ff,
	"YELLOWYELLOW": 0xfdd835ff,
	"YELLOWRED": 0xfb8c00ff,
	"YELLOWBLUE": 0x0a8f08ff
}

var primary_colors = ['RED', 'BLUE', 'YELLOW']
var complex_colors = ["BLUEBLUE", "BLUERED", "BLUEYELLOW", "REDRED", "REDBLUE", "REDYELLOW", "YELLOWYELLOW", "YELLOWRED", "YELLOWBLUE"]
var deduped_complex_colors = ["BLUEBLUE", "REDRED", "YELLOWYELLOW", "REDBLUE", "REDYELLOW", "YELLOWBLUE"]



# SOUNDS
var sound_node = load("res://Sound.tscn")

var hover_01: AudioStream = load("res://Assets/sounds/UI/hover-01.wav")
var hover_02: AudioStream = load("res://Assets/sounds/UI/hover-02.wav")
var hover_03: AudioStream = load("res://Assets/sounds/UI/hover-03.wav")
var select_click_01: AudioStream = preload("res://Assets/sounds/UI/select-click-01.wav")


var hover_sounds = [hover_01, hover_02, hover_03]

var default_sfx_volume = 0.0



func _ready():
	# Seed the randomizer
	randomize()

func change_sfx_volume(new_volume):
	default_sfx_volume = new_volume

func play(sound):
	var audio: AudioStream
	var volume = default_sfx_volume
	match sound:
		'hover':
			audio = hover_sounds[randi() % hover_sounds.size()]
			volume = -10
		'select-button':
			audio = select_click_01
			volume = -20
	var sound_obj = sound_node.instantiate()
	$SoundManager.add_child(sound_obj)
	sound_obj.play_sound(audio, volume)


func clear_all_audio():
	for child in $SoundManager.get_children():
		child.queue_free()


















