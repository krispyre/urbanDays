extends Level
@onready var results_transition: ResultsTransition = $ResultsTransition
#todo change transition and miss anim and winfail graphic
func _level_ready():
	isResultsShown = false

func _on_timer_timeout():
	win.emit()

func _on_floor_body_entered(_body: Node2D) -> void:
	await get_tree().create_timer(.5).timeout
	fail.emit()

func _on_win():
	if not mark_results_shown():
		return
	results_transition.play_win()

func _on_fail() -> void:
	if not mark_results_shown():
		return
	results_transition.play_fail()
