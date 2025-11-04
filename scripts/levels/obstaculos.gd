extends CharacterBody2D

var velocidade = Vector2.ZERO
var speed = 0.0

func _ready():
	randomize()  # garante aleatoriedade diferente a cada execução
	
	var sorteia_carro = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var carro_cor = sorteia_carro[randi() % sorteia_carro.size()]
	
	$AnimatedSprite2D.play(carro_cor)
	carro_rapido()  # define velocidade inicial

func carro_rapido():
	speed = randf_range(700.0, 750.0)

func carro_lento():
	speed = randf_range(300.0, 350.0)

func _physics_process(delta):
	velocidade = Vector2(1, 0) * speed * delta
	move_and_collide(velocidade)



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("destruiu")
	queue_free()
