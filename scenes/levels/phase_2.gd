extends Node

var posicaoPlayer1: Vector2 = Vector2.ZERO
var posicaoPlayer2: Vector2 = Vector2.ZERO

const CENA_OBSTACULO := preload("res://scenes/levels/obstaculos_egito.tscn")

# Cada faixa tem uma posição Y e se é rápida ou lenta
const FAIXAS: Array = [

	{ "y": 310.0, "rapida": false }, # nova faixa lenta superior
	{ "y": 340.0, "rapida": true  },
	{ "y": 370.0, "rapida": true  },
	{ "y": 400.0, "rapida": true  },
	{ "y": 430.0, "rapida": false },
	{ "y": 460.0, "rapida": false },

]

const MAX_OBSTACULOS: int = 20
const MIN_DIST_X_MESMA_FAIXA: float = 260.0  # mais alto = mais espaçado

var indice_faixa_atual: int = 0


func _ready() -> void:
	randomize()

	# guarda posição inicial dos players, se existirem
	if has_node("player"):
		posicaoPlayer1 = $player.position
	if has_node("player2"):
		posicaoPlayer2 = $player2.position

	# liga o timer se existir na cena
	var timer := get_node_or_null("Timer_obstaculo")
	if timer:
		timer.start()
	else:
		print("Aviso: Timer_obstaculo não encontrado na fase.")


# ==========================================================
# RESPAWN
# ==========================================================

func respawn_player1() -> void:
	if has_node("player"):
		$player.position = posicaoPlayer1
		print("Player 1 atropelado!")


func respawn_player2() -> void:
	if has_node("player2"):
		$player2.position = posicaoPlayer2
		print("Player 2 atropelado!")


# ==========================================================
# PORTAL
# ==========================================================

func _on_Portal_area_entered(area: Area2D) -> void:
	if area.name == "player":
		respawn_player1()
	elif area.name == "player2":
		respawn_player2()

	if has_node("AudioStreamPlayer2D"):
		$AudioStreamPlayer2D.play()


# ==========================================================
# CONTROLE DE SPAWN
# ==========================================================

func _pode_spawnar_na_faixa(faixa_idx: int) -> bool:
	# não deixar lotar demais a tela
	var total: int = get_tree().get_nodes_in_group("obstaculos").size()
	if total >= MAX_OBSTACULOS:
		return false

	# impede carros grudados na MESMA faixa
	for n in get_tree().get_nodes_in_group("obstaculos"):
		if n.faixa_index == faixa_idx:
			# região perto do spawn: de -200 até -150 + MIN_DIST_X_MESMA_FAIXA
			if n.position.x > -200.0 and n.position.x < (-150.0 + MIN_DIST_X_MESMA_FAIXA):
				return false

	return true


func _spawn_obstaculo_para_faixa(faixa_idx: int) -> void:
	if not _pode_spawnar_na_faixa(faixa_idx):
		return

	var dados = FAIXAS[faixa_idx]
	var y: float = dados["y"]
	var rapido: bool = dados["rapida"]

	var carro := CENA_OBSTACULO.instantiate()
	add_child(carro)

	# nasce um pouco fora da tela à esquerda
	carro.position = Vector2(-150.0, y)
	carro.faixa_index = faixa_idx

	if rapido and carro.has_method("carro_rapido"):
		carro.carro_rapido()
	elif not rapido and carro.has_method("carro_lento"):
		carro.carro_lento()




func _on_timer_obstaculos_timeout() -> void:
# a cada tic do timer, spawn em UMA faixa
	_spawn_obstaculo_para_faixa(indice_faixa_atual)

	# anda pra próxima faixa
	indice_faixa_atual = (indice_faixa_atual + 1) % FAIXAS.size()
