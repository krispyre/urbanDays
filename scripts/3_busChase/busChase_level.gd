extends Level
@onready var fail_spr: Node = $fail
@onready var win_spr: Node = $win
@onready var level: Node3D = $level
@onready var transition: SubViewport = $transition
@onready var tr_anim: AnimationPlayer = $transition/anim

@onready var goal: Area3D = $level/bus/goal

func _init():
	LEVEL_DURATION_BEAT = 17
	
func _level_ready() -> void:
	isFail = true
	
func on_beat(localBeat: int) -> void:
	pass
	#print("b owo")

func _on_level_win():
	win_spr.show()
	tr_anim.play("zoom")
	await tr_anim.animation_finished
	level.process_mode = Node.PROCESS_MODE_DISABLED
	print("win")
	isFail = false

func _on_level_fail() -> void:
	fail_spr.show()
	tr_anim.play("zoom")
	await tr_anim.animation_finished
	level.process_mode = Node.PROCESS_MODE_DISABLED
	print("fail")

func _on_goal_body_entered(_body: Node3D) -> void:
	win.emit()

func _on_timer_timeout() -> void:
	if (isFail):
		fail.emit()

func _on_hint_anim_finished(anim_name: StringName) -> void:
	start = true
	$level/player/Sprite3D.play("run")
