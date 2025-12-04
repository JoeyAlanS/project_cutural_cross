extends Control

func _on_btn_restart_pressed():
	# Reinicia a última fase jogada
	# Certifique-se que o Autoload se chama SceneManager no Project Settings
	scene_manager.restart_last_level(self)

func _on_btn_quit_pressed():
	# Em vez de fechar o jogo, volta para o menu (title.tscn)
	scene_manager.go_to_title(self)
	# Se quiser fechar o jogo mesmo, use: get_tree().quit()
