extends Level
@onready var results_transition: ResultsTransition = $ResultsTransition

func _on_win():
	if not mark_results_shown():
		return
	results_transition.play_win()

func _on_fail() -> void:
	if not mark_results_shown():
		return
	results_transition.play_fail()
