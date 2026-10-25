extends Level

@onready var bun: AnimatedSprite2D = $think/bun
@onready var lana_anim: AnimationPlayer = $lana/lana_anim

var correct_bun = 0
func _level_ready() -> void:
	isFail = true
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
	print("correct")
	lana_anim.play("jump")
	isFail = false

func _on_fail() -> void:
	print("false")
	lana_anim.play("oops")


func _on_timer_timeout():
	# can't set this
	if isFail:
		hint_anim_player.play("showFail")
	else:
		hint_anim_player.play("showWin")
