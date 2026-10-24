class_name Level extends Scene

const bgmScene = preload("res://scenes/bgm.tscn")

signal win
signal fail
signal timeout

var start = false
var isFail = false

## 1-indexed gameplay level (matches bgm.level_beat_offset)
@export var level_number: int = 1
var beat_offset: int = 0
var cur_beat := -1
var musicNode: bgm

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
	prints(shared)
	if shared:
		musicNode = shared
	else:
		print("testing one level")
		musicNode = bgmScene.instantiate() as bgm
		add_child(musicNode)
		# add_child during _ready defers t child's _ready/@onready until next idle frame
		musicNode.get_node("music_player").seek(beat_offset * 60.0 / musicNode.bpm)
	
	musicNode.r.beat.connect(func(globalBeat): on_beat(globalBeat - beat_offset)) # returns the current beat out of the whole music
	$animPlayer.play("showHint")
	_level_ready()

func _on_anim_finished(anim_name: StringName) -> void:
	if anim_name=="showHint":
		start = true
		
#these stuff are for overides
func _level_ready() -> void:
	pass

func on_beat(localBeat: int) -> void:
	pass
