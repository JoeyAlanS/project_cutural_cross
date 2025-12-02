extends Control
func _on_btn_back_pressed() -> void:
	settingsManager.save_settings()
	get_tree().change_scene_to_file("res://scenes/huds/title.tscn")
	queue_free()
