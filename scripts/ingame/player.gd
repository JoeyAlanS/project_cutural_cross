extends Area2D

var speed = 150
var tamanho_tela
var posicaoplayer = Vector2.ZERO

func _ready():
	tamanho_tela = get_viewport_rect().size

func _process(delta):
	posicaoplayer = Vector2.ZERO  # reseta movimento

	# Movimento vertical
	if Input.is_action_pressed("ui_down"):
		posicaoplayer.y = 1
		$AnimatedSprite2D.play("Descer")
	elif Input.is_action_pressed("ui_up"):
		posicaoplayer.y = -1
		$AnimatedSprite2D.play("Subir")

	# Movimento horizontal
	elif Input.is_action_pressed("ui_right"):
		posicaoplayer.x = 1
		$AnimatedSprite2D.play("Direita")
	elif Input.is_action_pressed("ui_left"):
		posicaoplayer.x = -1
		$AnimatedSprite2D.play("Esquerda")
	else:
		$AnimatedSprite2D.stop()

	# Normaliza para velocidade constante nas diagonais
	if posicaoplayer != Vector2.ZERO:
		posicaoplayer = posicaoplayer.normalized()

	# Atualiza posição
	position += posicaoplayer * speed * delta

	# Impede sair da tela
	position.x = clamp(position.x, 0, tamanho_tela.x)
	position.y = clamp(position.y, 0, tamanho_tela.y)
