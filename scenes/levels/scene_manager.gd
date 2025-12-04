extends CanvasLayer

# NOTA: Remova "class_name SceneManager" daqui para evitar o erro de função estática.
# O Godot vai usar o nome que você definiu no Project Settings -> Autoload.

@onready var animation: AnimationPlayer = $transitionAnimation

# Variável para lembrar qual foi a última fase JOGÁVEL
var last_level_played: String = "phase-1" 

# Caminhos base
var levels_path = "res://scenes/levels/"
var huds_path = "res://scenes/huds/" 

func _get_music_path_for_scene(scene_name: String) -> String:
	match scene_name:
		"phase_1_1", "phase-1":
			return "res://assets/sounds/japan.mp3"
		"phase_1_2", "phase-2":
			return "res://assets/sounds/egito.mp3"
		"phase_2_3", "phase_3":
			return "res://assets/sounds/brasil.mp3"
		"main-menu", "title", "game_over": 
			return "res://assets/sounds/main-menu-music.mp3"
		_:
			return ""

func change_scene(from, to_scene_name: String) -> void:
	# 1. Tocar música
	var music_path = _get_music_path_for_scene(to_scene_name)
	if has_node("/root/musicPlayer"): 
		get_node("/root/musicPlayer").play_new_music(music_path)
	
	# 2. Salvar última fase (Ignora menus)
	# Se não for Game Over nem Title, salvamos como fase jogável
	if to_scene_name != "game_over" and to_scene_name != "title":
		last_level_played = to_scene_name

	# 3. Animação de saída
	if animation:
		animation.play("transition_out")
		await animation.animation_finished
	
	# 4. Definir caminho
	var full_path = ""
	
	# Se for game_over ou title, busca na pasta HUDS. O resto na pasta LEVELS.
	if to_scene_name == "game_over" or to_scene_name == "title":
		full_path = huds_path + to_scene_name + ".tscn"
	else:
		full_path = levels_path + to_scene_name + ".tscn"
	
	# 5. Troca de cena
	from.get_tree().call_deferred("change_scene_to_file", full_path)
	
	# 6. Animação de entrada
	if animation:
		animation.play_backwards("transition_out")

# Esta função é chamada pelo botão de reiniciar
func restart_last_level(from_node) -> void:
	change_scene(from_node, last_level_played)

# Esta função é chamada pelo botão de sair (para voltar ao menu/title)
func go_to_title(from_node) -> void:
	change_scene(from_node, "title")
