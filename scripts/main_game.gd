extends Scene

var lives = 3
func _unhandled_input(event: InputEvent):
	if (event.is_action_pressed("pause")):
		$gameProcess.paused = !$gameProcess.paused

func _on_bgm_outro() -> void:
	print("play outro")

func _on_bgm_next_level() -> void:
	print("next")
