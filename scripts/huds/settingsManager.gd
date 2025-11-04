extends Node

const SAVE_FILE_PATH = "user://game_settings.cfg"

var master_volume_linear: float = 0.8
var musica_volume_linear: float = 0.8
var sfx_volume_linear: float = 0.8
var is_fullscreen: bool = true

func _ready() -> void:
	load_settings() 
	apply_settings()  

func apply_settings() -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), master_volume_linear)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("MUSIC"), musica_volume_linear)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), sfx_volume_linear)
	
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func save_settings() -> void:
	var config = ConfigFile.new()
	
	config.set_value("Audio", "master_volume", master_volume_linear)
	config.set_value("Audio", "musica_volume", musica_volume_linear)
	config.set_value("Audio", "sfx_volume", sfx_volume_linear)
	
	config.set_value("Display", "fullscreen", is_fullscreen)
	
	var error = config.save(SAVE_FILE_PATH)
	if error == OK:
		print("Configurações salvas em: ", SAVE_FILE_PATH)
	else:
		print("Erro ao salvar configurações: ", error) 

func load_settings() -> void:
	var config = ConfigFile.new()
	var error = config.load(SAVE_FILE_PATH)
	
	if error != OK:
		print("Arquivo de configurações não encontrado. Usando valores padrão.")
		return  
	
	master_volume_linear = config.get_value("Audio", "master_volume", master_volume_linear)
	musica_volume_linear = config.get_value("Audio", "musica_volume", musica_volume_linear)
	sfx_volume_linear = config.get_value("Audio", "sfx_volume", sfx_volume_linear)
	
	is_fullscreen = config.get_value("Display", "fullscreen", is_fullscreen)
	
	print("Configurações carregadas.")  
