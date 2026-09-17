class_name Scene extends Node

func _unhandled_input(event: InputEvent):
	if (event.is_action_pressed("restart")):
		get_tree().paused = false
		get_tree().reload_current_scene()
	if (event.is_action_pressed("timeToggle")):
		if Engine.time_scale == 1:
			Engine.time_scale = 0.1
		else:
			Engine.time_scale = 1
