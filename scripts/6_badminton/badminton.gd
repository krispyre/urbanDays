extends Level
@onready var results_transition: ResultsTransition = $ResultsTransition

func _level_ready():
	isFail = false
	
func _on_timer_timeout():
	win.emit()

func _on_floor_body_entered(body: Node2D) -> void:
	print("ball drops to floor, fail")
	isFail = true
	fail.emit()

func _on_win():
	results_transition.play_win()

func _on_fail() -> void:
	results_transition.play_fail()
