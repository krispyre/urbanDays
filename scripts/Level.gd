class_name Level extends Scene

signal win
signal fail

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("autoWin")):
		win.emit()
	elif (event.is_action_pressed("autoFail")):
		fail.emit()
	else:
		super._unhandled_input(event)
