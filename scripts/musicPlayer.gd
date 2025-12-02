extends AudioStreamPlayer

var is_paused_by_game: bool = false

func _ready() -> void:
	play_new_music("res://assets/sounds/main-menu-music.mp3")

func play_new_music(music_path: String) -> void:
	if music_path == "": 
		stop()
		return
	
	stop()
	stream = load(music_path)
	bus = "MUSIC"
	play()
	is_paused_by_game = false

func stop_music() -> void:
	stop()
	is_paused_by_game = false

func pause_music() -> void:
	if playing:
		set_stream_paused(true)
		is_paused_by_game = true

func unpause_music() -> void:
	if get_stream_paused():
		set_stream_paused(false)
		is_paused_by_game = false
