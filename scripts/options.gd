extends Control

@onready var sld_volume_global = $MarginContainer/HBoxContainer/VBoxContainer/sld_volume_global
@onready var sld_volume_musica = $MarginContainer/HBoxContainer/VBoxContainer/sld_volume_musica
@onready var sld_sound_effect = $MarginContainer/HBoxContainer/VBoxContainer/sld_sound_effect
@onready var chbox_fullscreen = $MarginContainer/HBoxContainer/VBoxContainer/chbox_fullscreen

func _ready() -> void:
	print("settingsManager: ", settingsManager) 
	sld_volume_global.value = settingsManager.master_volume_linear
	sld_volume_musica.value = settingsManager.musica_volume_linear
	sld_sound_effect.value = settingsManager.sfx_volume_linear
	
	chbox_fullscreen.button_pressed = settingsManager.is_fullscreen


func _on_btn_back_pressed() -> void:
	settingsManager.save_settings()
	get_tree().change_scene_to_file("res://scenes/title.tscn")

func _on_chbox_fullscreen_toggled(toggled_on: bool) -> void:
	settingsManager.is_fullscreen = toggled_on
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func update_audio_bus(bus_name: String, value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(bus_name), value)


func _on_sld_volume_musica_value_changed(value: float) -> void:
	settingsManager.musica_volume_linear = value
	update_audio_bus("MUSIC", value)


func _on_sld_volume_global_value_changed(value: float) -> void:
	settingsManager.master_volume_linear = value
	update_audio_bus("Master", value)


func _on_sld_sound_effect_value_changed(value: float) -> void:
	settingsManager.sfx_volume_linear = value
	update_audio_bus("SFX", value)
