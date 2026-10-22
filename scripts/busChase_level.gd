extends Level
@onready var fail_spr: Node = $fail
@onready var win_spr: Node = $win
@onready var level: Node3D = $level
@onready var transition: SubViewport = $transition
@onready var tr_anim: AnimationPlayer = $transition/anim
@onready var hint_anim_player: AnimationPlayer = $animPlayer

@onready var goal: Area3D = $level/bus/goal
@onready var timer: Timer = $level/Timer
@onready var progress_bar: TextureProgressBar = $level/Container/ProgressBar
var isWin = false

func _init() -> void:
	beat_offset = 31+8*2
	# 3rd level: 31 beats +2 levels before this level

func _level_ready() -> void:
	hint_anim_player.play("showHint")
	progress_bar.max_value = 9*60/musicNode.bpm
	timer.wait_time =  progress_bar.max_value +hint_anim_player.get_animation("showHint").length
	progress_bar.value = progress_bar.max_value
	timer.start()
	prints(progress_bar.value, timer.wait_time)
	

func _process(_delta: float) -> void:
	print(progress_bar.value)
	if is_instance_valid(timer):
		progress_bar.value = timer.time_left

func on_beat(localBeat: int) -> void:
	pass
	#print("b owo")

func _on_level_win():
	win_spr.show()
	tr_anim.play("zoom")
	await tr_anim.animation_finished
	level.hide()
	print("win")
	isWin = true

func _on_level_fail() -> void:
	fail_spr.show()
	tr_anim.play("zoom")
	await tr_anim.animation_finished
	level.hide()
	print("fail")

func _on_goal_body_entered(_body: Node3D) -> void:
	win.emit()

func _on_timer_timeout() -> void:
	if (!isWin):
		fail.emit()


func _on_hint_anim_finished(anim_name: StringName) -> void:
	$level/player/Sprite3D.play("run")
