extends Node

#@onready var building_placeholder = $Buildings # This is an InstancePlaceholder at runtime
#
#func _on_player_approached():
	#if building_placeholder is InstancePlaceholder:
		## Spawns the original child scene right where it belongs
		#var actual_node = building_placeholder.create_instance() 
const bpm = 175;