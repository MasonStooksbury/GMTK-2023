extends Node2D



var zoomed_in_num = 2.8
var zoomed_out_num = 1.25
var distance_min = 10
var distance_max = 600

@onready var player1 = $Player
@onready var player2 = $Player2
@onready var camera = $Camera2D



func _process(_delta):
	player_health_check()
	var midpoint = (player1.global_transform.origin + player2.global_transform.origin)/2
	var distance = (player1.global_transform.origin).distance_to(player2.global_transform.origin)

	handle_zoom(distance)
	camera.global_transform.origin = midpoint



func handle_zoom(distance):
	var zoom_percent = 1 - (distance / (distance_max - distance_min))
	var zoom_num = zoomed_in_num * zoom_percent
	zoom_num = zoomed_out_num if zoom_num < zoomed_out_num else zoom_num

	camera.zoom = Vector2(zoom_num, zoom_num)



func player_health_check():
	if player1.is_dead or player2.is_dead:
		get_tree().change_scene_to_packed(Global.ENDSCREEN_SCENE)
