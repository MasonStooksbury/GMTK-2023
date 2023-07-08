extends Node2D

var zoom_max = 0.5
var zoom_min = 0.7
var distance_min = 10
var distance_max = 600


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_vector = ($Player.global_transform.origin + $Player2.global_transform.origin)/2
	var distance = ($Player.global_transform.origin).distance_to($Player2.global_transform.origin)

	handle_zoom(distance)
	$Camera2D.global_transform.origin = new_vector


func handle_zoom(distance):
	var zoom_percent = distance / (distance_max - distance_min)
	zoom_percent = zoom_min if zoom_percent > zoom_min else zoom_percent
	zoom_percent = zoom_max if zoom_percent < zoom_max else zoom_percent
	
	$Camera2D.zoom = Vector2(1-zoom_percent, 1-zoom_percent)
