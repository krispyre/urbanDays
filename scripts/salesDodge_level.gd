extends Level

@onready var goal: Marker3D = $goal
@onready var player_body: Area3D = $playerView/playerBody

func _physics_process(delta: float) -> void:
	#print(player_body.global_position.z, " ",goal.global_position.z)
	if player_body.global_position.z >= goal.global_position.z:
		_on_win()

func _on_win():
	get_tree().paused = true
	print("win")
	win.emit()
