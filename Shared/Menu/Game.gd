extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var player1_pos = $Player.global_transform.origin
	var stuff = player1_pos.distance_to($Player2.global_transform.origin)
	print(stuff)
#	$Camera2D.global_transform = $Player.global_transform


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var player1_pos = $Player.global_transform.origin
#	player1_pos.distance_to($Player2.global_transform.origin)
#
#
#	$Camera2D.global_transform = $Player.global_transform
