# Nome do script: title.gd
extends Control


func _ready() -> void:
	pass
func _on_btn_start_pressed() -> void:
	musicPlayer.play_new_music("res://assets/sounds/Corrida no Torii.mp3") 
	
	get_tree().change_scene_to_file("res://scenes/levels/phase-1.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/huds/options.tscn")

func _on_btn_quit_pressed() -> void:
	get_tree().quit()
