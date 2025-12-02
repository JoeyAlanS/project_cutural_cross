# Nome do script: title.gd
extends Control


func _ready() -> void:
	pass
func _on_btn_start_pressed() -> void:
	musicPlayer.play_new_music("res://assets/sounds/japan.mp3") 
	
	get_tree().change_scene_to_file("res://scenes/levels/phase_1_1.tscn")

func _on_btn_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/huds/options.tscn")

func _on_btn_quit_pressed() -> void:
	get_tree().quit()


func _on_btn_help_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/huds/help.tscn")
