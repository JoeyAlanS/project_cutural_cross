extends CanvasLayer

@onready var animator: AnimationPlayer = $animator
@onready var btn_resume: Button = $bg_overlay/menu_holder/btn_resume
@onready var btn_options: Button = $bg_overlay/menu_holder/btn_options
@onready var btn_quit: Button = $bg_overlay/menu_holder/btn_quit

const OPTIONS_SCENE = preload("res://scenes/huds/options.tscn")

func _ready() -> void:
	visible = false

func open_pause_menu():
	show()
	$bg_overlay.visible = true
	animator.play("pause_game")


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		$bg_overlay.visible = true
		animator.play("pause_game")
		get_tree().paused = true


func _on_btn_resume_pressed():
	animator.play("resume_game")
	get_tree().paused = false
	await animator.animation_finished
	visible = false


func _on_btn_quit_pressed():
	get_tree().change_scene_to_file("res://scenes/huds/title.tscn")


func _on_btn_options_pressed():
	hide()  # melhor que visible = false

	var options = OPTIONS_SCENE.instantiate()
	add_child(options)
