class_name Scene extends Node

func _unhandled_input(event: InputEvent):
	if (event.is_action_pressed("restart")):
		get_tree().reload_current_scene()
