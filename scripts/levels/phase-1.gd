extends Node

var posicaoPlayer1 = Vector2.ZERO
var posicaoPlayer2 = Vector2.ZERO

const cenaObstaculos = preload("res://scenes/levels/obstaculos.tscn")
const FaixaRapida = [488, 272, 104]
const FaixaLenta = [600, 544, 438, 324, 384, 216, 160]

func _ready():
	posicaoPlayer1 = $player.position
	posicaoPlayer2 = $player2.position

func _on_Portal_area_entered(area):
	if area.name == "player":
		$player.position = posicaoPlayer1
	if area.name == "player2":
		$player2.position = posicaoPlayer2

	$AudioStreamPlayer2D.play()


func _on_timer_timeout() -> void:
	pass # Replace with function body.

# Nova função adicionada
func _on_TimerCarroRapido_timeout():
	var spawnCarro = cenaObstaculos.instance()
	add_child(spawnCarro)
	
	spawnCarro.position.x = -10
	spawnCarro.position.y = FaixaRapida[randi() % FaixaRapida.size()]
	spawnCarro.carro_rapido()


func _on_player_body_entered(body: Node2D) -> void:
	print("fui atropeladoww") # Replace with function body.
