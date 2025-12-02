class_name SceneManager extends CanvasLayer

@onready var animation: AnimationPlayer = $transitionAnimation
var last_scene_name: String
var scene_dir_path = "res://scenes/levels/"

# Função para mapear o nome da cena para o caminho da música
func _get_music_path_for_scene(scene_name: String) -> String:
	match scene_name:
		"phase-1":
			return "res://assets/sounds/japan.mp3" 
		"phase-2":
			return "res://assets/sounds/egito.mp3"
		"main-menu": 
			return "res://assets/sounds/main-menu-music.mp3"
		_:
			# Retorna String vazia para parar a música se não houver música específica
			return "" 

func change_scene(from, to_scene_name: String) -> void:
	# 1. Obter o caminho da música para a nova cena
	var music_path = _get_music_path_for_scene(to_scene_name)
	
	# 2. Chamar o Autoload (Singleton) MusicManager para tocar a nova música
	# Use o nome que você definiu na configuração do Autoload (ex: MusicManager)
	musicPlayer.play_new_music(music_path)
	
	last_scene_name = from.name
	
	animation.play("transition_out")
	await animation.animation_finished
	
	var full_path = scene_dir_path + to_scene_name + ".tscn"
	from.get_tree().call_deferred("change_scene_to_file", full_path)
	
	animation.play_backwards("transition_out")
