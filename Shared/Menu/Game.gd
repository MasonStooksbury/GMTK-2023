extends Node2D

#var zoom_max = 0.5
#var zoom_min = 0.7
#var distance_min = 10
#var distance_max = 600

var zoom_max = 3
var distance_min = 10
var distance_max = 600


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_health_check()
	var midpoint = ($Player.global_transform.origin + $Player2.global_transform.origin)/2
	var distance = ($Player.global_transform.origin).distance_to($Player2.global_transform.origin)

	handle_zoom(distance)
	$Camera2D.global_transform.origin = midpoint


func handle_zoom(distance):
	# Approaches 1 the further you get from each other
	# Approaches 0 the closer you get
	var zoom_percent = distance / (distance_max - distance_min)

	var zoom_num = zoom_max / 1.25 - zoom_percent

	
	
	$Camera2D.zoom = Vector2(zoom_num, zoom_num)
	
func player_health_check():
	if $Player.is_dead or $Player2.is_dead:
		get_tree().change_scene_to_file("res://Shared/EndScreen.tscn")
