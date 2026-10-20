extends Level
@onready var fail_spr: Node = $fail
@onready var win_spr: Node = $win
@onready var level: Node3D = $level
@onready var transition: SubViewport = $transition
@onready var tr_anim: AnimationPlayer = $transition/anim
@onready var goal: Area3D = $level/bus/goal
@onready var timer: Timer = $level/Timer
@onready var progress_bar: TextureProgressBar = $level/Container/ProgressBar

func _ready():
	fail_spr.hide()
	win_spr.hide()
	level.show()
	progress_bar.max_value = timer.wait_time
	get_tree().paused = false

func _process(_delta: float) -> void:
	if is_instance_valid(timer):
		progress_bar.value = timer.time_left

func _on_level_win():
	win_spr.show()
	tr_anim.play("zoom")
	await tr_anim.animation_finished
	level.hide()
	level.queue_free()
	print("win")

func _on_level_fail() -> void:
	fail_spr.show()
	tr_anim.play("zoom")
	await tr_anim.animation_finished
	level.hide()
	level.queue_free()
	print("fail")

func _on_goal_body_entered(_body: Node3D) -> void:
	win.emit()

func _on_timer_timeout() -> void:
	fail.emit()
