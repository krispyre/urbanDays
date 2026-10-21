extends Level
@onready var fail_spr: Node = $fail
@onready var win_spr: Node = $win
@onready var level: Node3D = $level
@onready var transition: SubViewport = $transition
@onready var tr_anim: AnimationPlayer = $transition/anim
@onready var goal: Area3D = $level/bus/goal
@onready var timer: Timer = $level/Timer
@onready var progress_bar: TextureProgressBar = $level/Container/ProgressBar

func _level_ready() -> void:
	fail_spr.hide()
	win_spr.hide()
	level.show()
	progress_bar.max_value = timer.wait_time

func _process(_delta: float) -> void:
	if is_instance_valid(timer):
		progress_bar.value = timer.time_left

func on_beat(localBeat: int) -> void:
	print("b owo")

func _on_level_win():
	win_spr.show()
	tr_anim.play("zoom")
	await tr_anim.animation_finished
	level.hide()
	print("win")
	get_tree().paused = true

func _on_level_fail() -> void:
	fail_spr.show()
	tr_anim.play("zoom")
	await tr_anim.animation_finished
	level.hide()
	print("fail")
	get_tree().paused = true

func _on_goal_body_entered(_body: Node3D) -> void:
	win.emit()

func _on_timer_timeout() -> void:
	fail.emit()
