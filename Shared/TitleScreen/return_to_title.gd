extends Control


func _on_button_pressed() -> void:
	var _error = get_tree().change_scene_to_file("res://Shared/TitleScreen/TitleScreen.tscn")


#func _on_MusicSlider_value_changed(value: float) -> void:
#	get_node('/root/Globals')._change_music_volume(value)
