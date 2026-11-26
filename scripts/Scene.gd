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
	

# where do you put helper methdods
func random_n_numbers(min:int, max:int, n:int)-> Array[int]:
	## Max is exclusive. Make sure n is less than (max-min).
	var res = []
	for i in range(min,max):
		res.append(i)
	res.shuffle()
	return res.slice(0,n)
		


func _on_start_focus_entered() -> void:
	pass # Replace with function body.
