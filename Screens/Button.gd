extends Button

@export var next_scene: PackedScene
@export_flags('---') var is_back = 0

func _on_pressed():
	if not is_back:
		Global.play('select-button')
		get_tree().change_scene_to_packed(next_scene)


func _on_mouse_entered():
	Global.play('hover')
