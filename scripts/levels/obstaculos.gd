extends CharacterBody2D

var speed: float = 0.0
var faixa_index: int = -1   # setado pela fase

func _ready() -> void:
	randomize()
	add_to_group("obstaculos")

	# começa como lento, por padrão
	carro_lento()


func carro_rapido() -> void:
	speed = randf_range(650.0, 750.0)
	if $AnimatedSprite2D.sprite_frames.has_animation("carro_rapido"):
		$AnimatedSprite2D.play("carro_rapido")


func carro_lento() -> void:
	speed = randf_range(300.0, 380.0)
	if $AnimatedSprite2D.sprite_frames.has_animation("carro_lento"):
		$AnimatedSprite2D.play("carro_lento")


func _physics_process(delta: float) -> void:
	velocity = Vector2(speed, 0.0)
	var colisao := move_and_collide(velocity * delta)

	if colisao:
		var body = colisao.get_collider()
		var root := get_tree().current_scene

		if body.name == "player" and root and root.has_method("respawn_player1"):
			root.respawn_player1()
		elif body.name == "player2" and root and root.has_method("respawn_player2"):
			root.respawn_player2()


func _on_VisibleOnScreenNotifier2D_screen_exited() -> void:
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
