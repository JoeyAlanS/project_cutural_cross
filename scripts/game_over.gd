extends Control


func _on_btn_restart_pressed():
	get_tree().change_scene_to_file("res://scenes/title.tscn")


func _on_btn_quit_pressed():
	get_tree().quit()
