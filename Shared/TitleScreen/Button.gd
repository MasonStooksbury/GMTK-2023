extends Button

@export var next_scene: PackedScene

#func _ready() -> void:
#	$AnimationPlayer.play("Pulse")

func _on_pressed():
	print('F')
	get_tree().change_scene_to_packed(next_scene)
