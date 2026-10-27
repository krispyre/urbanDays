class_name Level extends Scene

const bgmScene = preload("res://scenes/bgm.tscn")
@onready var progress_bar: TextureProgressBar = $timeLeft/ProgressBar
@onready var timer: Timer = $timeLeft/Timer
@onready var hint_anim_player: AnimationPlayer = $animPlayer

@onready var win_spr: Node2D = %win #add these to ur code!
@onready var fail_spr: Node2D = %fail

signal win
signal fail

var start = false
var isFail = true

## 1-indexed gameplay level (matches bgm.level_beat_offset)
@export var level_number: int = 1
var beat_offset: int = 0
var cur_beat := -1
var musicNode: bgm

var LEVEL_DURATION_BEAT := 8 #timeout AFTER 8th beat

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("autoWin")):
		win.emit()
	elif (event.is_action_pressed("autoFail")):
		fail.emit()
	else:
		super._unhandled_input(event)

func _ready() -> void:
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
	
	_level_ready()
	
func _process(delta: float) -> void:
	progress_bar.value = timer.time_left
	prints(isFail)	
	_level_process(delta)

func _on_anim_finished(anim_name: StringName) -> void:
	if anim_name=="showHint":
		start = true
		
#these stuff are for overides
func _level_ready() -> void:
	pass
	
func _level_process(delta) -> void:
	pass

func on_beat(localBeat: int) -> void:
	pass
	
func _on_timer_timeout() -> void:
	if (isFail):
		fail.emit()
