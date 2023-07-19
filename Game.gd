extends Node2D



@onready var player1 = $Player1
@onready var player2 = $Player2
@onready var camera = $Camera2D

var zoomed_in_num = 2.8
var zoomed_out_num = 1.25
var distance_min = 10
var distance_max = 600
var spawn_options_coordinates = []



func _ready():
	if name != 'HowTo':
		for option in $PlayerSpawnOptions.get_children():
			spawn_options_coordinates.append(option.global_transform.origin)



func _process(_delta):
	player_health_check()
	var midpoint = (player1.global_transform.origin + player2.global_transform.origin)/2
	var distance = (player1.global_transform.origin).distance_to(player2.global_transform.origin)

	handle_zoom(distance)
	camera.global_transform.origin = midpoint



func get_furthest_spawn_point_position(player_num):
	# Let's get the other
	var other_player
	for player in Global.players.keys():
		if player != player_num:
			other_player = get_node(player)

	var possible_spawns = []
	for option in spawn_options_coordinates:
		possible_spawns.append({
			'coordinates': option,
			'distance': other_player.global_transform.origin.distance_to(option)
		})

	# This custom sort lambda will sort the array from smallest to largest distance
	possible_spawns.sort_custom(func(a, b): return a['distance'] < b['distance'])

	# Pick last 3 options
	var furthest_possible_spawns = possible_spawns.slice(-3)

	# Return a random one
	return furthest_possible_spawns[randi() % furthest_possible_spawns.size()].coordinates



func handle_zoom(distance):
	var zoom_percent = 1 - (distance / (distance_max - distance_min))
	var zoom_num = zoomed_in_num * zoom_percent
	zoom_num = zoomed_out_num if zoom_num < zoomed_out_num else zoom_num

	camera.zoom = Vector2(zoom_num, zoom_num)



func player_health_check():
	if player1.is_dead or player2.is_dead:
		get_tree().change_scene_to_packed(Global.ENDSCREEN_SCENE)
