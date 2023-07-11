extends Control
# READ ME
# Weirdly enough, this is required because you cannot load a packed scene cyclically.
# The "back" button of whatever menu you have has to do this method. I.e. calling it via change_scene_to_file()


func _on_pressed():
	get_tree().change_scene_to_packed(Global.TITLESCREEN_SCENE)
