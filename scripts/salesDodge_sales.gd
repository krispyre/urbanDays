extends Node

var dir
func _ready() -> void:
	for child in get_children():
		if child.name != dir:
			child.monitoring = false
			child.monitorable = false
			child.get_node("hb").disabled = true
			child.get_node("sprite").visible = false
		else:
			child.monitoring = true
			child.monitorable = true
			child.get_node("hb").disabled = false
			child.get_node("sprite").visible = true
		
