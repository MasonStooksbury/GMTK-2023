extends Node2D



var zoomed_in_num = 2.8
var zoomed_out_num = 1.25
var distance_min = 10
var distance_max = 600



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	player_health_check()
	var midpoint = ($Player.global_transform.origin + $Player2.global_transform.origin)/2
	var distance = ($Player.global_transform.origin).distance_to($Player2.global_transform.origin)

	handle_zoom(distance)
	$Camera2D.global_transform.origin = midpoint



func handle_zoom(distance):
	var zoom_percent = 1 - (distance / (distance_max - distance_min))
	var zoom_num = zoomed_in_num * zoom_percent
	zoom_num = zoomed_out_num if zoom_num < zoomed_out_num else zoom_num
	
	$Camera2D.zoom = Vector2(zoom_num, zoom_num)



func player_health_check():
	if $Player.is_dead or $Player2.is_dead:
		get_tree().change_scene_to_packed(Global.ENDSCREEN_SCENE)
