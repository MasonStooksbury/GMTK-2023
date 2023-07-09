extends Control


func _on_button_pressed() -> void:
	var _error = get_tree().change_scene_to_file("res://Shared/TitleScreen/TitleScreen.tscn")
