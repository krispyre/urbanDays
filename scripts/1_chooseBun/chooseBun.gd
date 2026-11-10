extends Level

@onready var bun: AnimatedSprite2D = $think/bun
@onready var lana_anim: AnimationPlayer = $lana/lana_anim
@onready var results: ResultsTransition = $ResultsTransition

var correct_bun = 0

func _level_ready() -> void:
	isResultsShown = false
	print(beat_offset)
	correct_bun = randi_range(0, bun.sprite_frames.get_frame_count("buns") - 1)
	bun.frame = correct_bun

func _on_bun_focused(index: int) -> void:
	if index == correct_bun:
		lana_anim.play("choose")
	else:
		lana_anim.play("think")

func _level_process(delta: float) -> void:
	#prints(progress_bar.value, timer.time_left)
	pass

func _on_bun_selected(index: int) -> void:
	if index == correct_bun:
		win.emit()
	else:
		fail.emit()

func _on_win() -> void:
	if not mark_results_shown():
		return
	print("correct")
	lana_anim.play("jump")
	await get_tree().create_timer(.5).timeout
	results.play_win()

func _on_fail() -> void:
	if not mark_results_shown():
		return
	print("fail")
	lana_anim.play("oops")
	await get_tree().create_timer(.5).timeout
	results.play_fail()

func _on_timer_timeout() -> void:
	fail.emit()
