extends Level

const bgmScene = preload("res://scenes/bgm.tscn")

@onready var time_left: Timer = $timeLeft
@onready var beat: Timer = $beat
@onready var goal: Marker3D = $bg_view/bg_world/goal
@onready var sales_container: Node = $salesContainer

@onready var fail_spr: Node = $fail
@onready var win_spr: Node = $win

const salesObj = preload("uid://bs5rrdfontsb2")

const beat_offset = (8+4)*4 #8+4 bars before this scene starts
const measure_count = 8

#each sales appear at most on each beat
var curBeat = 0
var sequence = [
	null,
	{"dir": "right"},
	null,
	{"dir": "left"},
	null,
	{"dir": "up"},
	null,
	{"dir": "down"},
	null,
] :
	set(val):
		assert(val.length <= measure_count*4)
		val.resize(measure_count*4)
		sequence = val

func _ready() -> void:
	sequence.resize(measure_count * 4)
	time_left.start()
	var music := get_node_or_null("../../bgm")
	if music:
		music.globalBeat.connect(_on_beat)
	else:
		music = bgmScene.instantiate()
		music.globalBeat.connect(_on_beat)
		add_child(music)
		music.get_node("music_player").seek(beat_offset * 60.0 / Globals.bpm)
	
func _on_win():
	print("win")
	win.emit()

func _on_player_body_area_entered(area: Area3D) -> void:
	print("die")
	fail.emit()

func _on_time_left_timeout() -> void:
	_on_win()

func _on_beat(globalBeat: int) -> void:
	curBeat = globalBeat - beat_offset
	print(curBeat)
	if curBeat < 0 or curBeat >= sequence.size():
		return
	var step = sequence[curBeat]
	if step == null:
		return
	
	var s = salesObj.instantiate()
	s.dir = step["dir"]
	s.position = sales_container.get_node(s.dir).position
	sales_container.add_child(s)
	
	
