extends Level
@onready var fail_spr: Node = $fail
@onready var win_spr: Node = $win
@onready var level: Node3D = $level
@onready var transition: SubViewport = $transition
@onready var tr_anim: AnimationPlayer = $transition/anim


@onready var goal: Area3D = $level/bus/goal

func _init():
	LEVEL_DURATION_BEAT = 17
	
#overriden from Level.gd _ready() dear god.....
func _ready() -> void:
	hint_anim_player = $animPlayer
	timer = $level/timeLeft/Timer
	progress_bar = $level/timeLeft/ProgressBar
	
	beat_offset = bgm.level_beat_offset(level_number)
	#only parent has the bgm node, testers no
	#either reference the bgm node in the parent or load ur own+offset (during testign)
	var shared := get_tree().current_scene.get_node_or_null("%bgm")
	if shared:
		print("globally playing")
		musicNode = shared
	else:
		print("testing one level")
		musicNode = bgmScene.instantiate() as bgm
		add_child(musicNode)
		# add_child during _ready defers t child's _ready/@onready until next idle frame
		musicNode.get_node("music_player").seek(beat_offset * 60.0 / musicNode.bpm)
	
	musicNode.r.beat.connect(func(globalBeat): on_beat(globalBeat - beat_offset)) # returns the current beat out of the whole music
	$animPlayer.play("showHint")
	
	progress_bar.max_value = LEVEL_DURATION_BEAT * 60.0 / musicNode.bpm
	timer.wait_time = progress_bar.max_value + hint_anim_player.get_animation("showHint").length
	progress_bar.value = progress_bar.max_value
	timer.start()
	prints(progress_bar.value, timer.wait_time)
	
	isFail = true
	
	_level_ready()
	
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
