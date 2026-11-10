class_name Level extends Scene

const bgmScene = preload("res://scenes/bgm.tscn")
@onready var progress_bar: TextureProgressBar = $timeLeft/ProgressBar
@onready var timer: Timer = $timeLeft/Timer
@onready var hint_anim_player: AnimationPlayer = $animPlayer

var win_spr: Node2D
var fail_spr: Node2D

signal win
signal fail

signal gameStart
var game_start = false
## First win or fail to arrive plays results. Later ones return.
var isResultsShown := false

## 1-indexed gameplay level (matches bgm.level_beat_offset)
@export var level_number: int = 1
var beat_offset: int = 0
var cur_beat := -1
var musicNode: bgm

var recharging = false
var timeout_time = 0
var LEVEL_DURATION_BEAT := 23 # timeout AFTER nth beat

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("autoWin")):
		win.emit()
	elif (event.is_action_pressed("autoFail")):
		fail.emit()
	else:
		super._unhandled_input(event)

func _ready() -> void:
	recharging = false
	isResultsShown = false
	var results := get_node_or_null("ResultsTransition") as ResultsTransition
	if results:
		win_spr = results.win
		fail_spr = results.fail
	else:
		win_spr = get_node_or_null("%win") as Node2D
		fail_spr = get_node_or_null("%fail") as Node2D

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
	prints("level dur bea", LEVEL_DURATION_BEAT)
	timer.wait_time = progress_bar.max_value + hint_anim_player.get_animation("showHint").length
	progress_bar.value = progress_bar.max_value
	timer.start()
	prints(progress_bar.value, timer.wait_time)
	if not timer.timeout.is_connected(_on_timer_timeout):
		# lambda so the subclass override runs, not Level's empty handler
		timer.timeout.connect(func(): _on_timer_timeout())
	
	_level_ready()
	
func _process(delta: float) -> void:
	if !recharging:
		progress_bar.value = timer.time_left
	else:
		progress_bar.value = musicNode.r.current_position - timeout_time
	_level_process(delta)

func _on_anim_finished(anim_name: StringName) -> void:
	if anim_name == "showHint":
		game_start = true
		gameStart.emit()
		
#these stuff are for overides
func _level_ready() -> void:
	pass
	
func _level_process(delta) -> void:
	pass

func on_beat(localBeat: int) -> void:
	pass
	
func set_timer_bar_recharge():
	#empty bar, prepare for recharge (cal in process)
	recharging = true
	progress_bar.value = 0
	timeout_time = musicNode.r.current_position
	#todo move to somewhere
		#beat when next lv loads
	var next_beat := bgm.level_beat_offset(level_number + 1) + bgm.EARLY_OFFSET
	var seconds_left := next_beat * musicNode.r.beat_length - musicNode.r.current_position
	progress_bar.max_value = seconds_left

## Returns true for the first caller, which should play the results.
func mark_results_shown() -> bool:
	if isResultsShown:
		return false
	isResultsShown = true
	set_timer_bar_recharge()
	return true

func _on_timer_timeout() -> void:
	pass

func _on_win() -> void:
	pass

func _on_fail() -> void:
	pass
