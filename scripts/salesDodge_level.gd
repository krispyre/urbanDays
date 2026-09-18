extends Level

@onready var time_left: Timer = $timeLeft
@onready var beat: Timer = $beat
@onready var goal: Marker3D = $bg_view/bg_world/goal
@onready var sales_container: Node = $salesContainer
const salesObj = preload("uid://bs5rrdfontsb2")


const timer_offset = 0
const measure_count = 8

#each sales appear at most on each beat
var curBeat = 0
var sequence = [
	{"dir": "right"},
	null,
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	null,
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	null,
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	null,
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"},
	{"dir": "right"}
] :
	set(val):
		assert(val.length == measure_count*4)
		sequence = val

func _ready() -> void:
	time_left.wait_time = 4 * measure_count * 60.0/Globals.bpm
	beat.wait_time = 60.0/Globals.bpm
	await get_tree().create_timer(timer_offset).timeout
	time_left.start()
	beat.start()
	
func _on_win():
	get_tree().paused = true
	print("win")
	win.emit()

func _on_player_body_area_entered(area: Area3D) -> void:
	print("die")
	fail.emit()

func _on_time_left_timeout() -> void:
	_on_win()

func _on_beat() -> void:
	var step = sequence[curBeat]
	curBeat += 1
	if step == null:
		return
	
	var s = salesObj.instantiate()
	s.dir = "right"
	s.position = Vector2(get_window().size.x, $"salesContainer/sales_target ref".position.y)
	sales_container.add_child(s)
	print("beat")
	
