extends Level

@onready var time_left: Timer = $timeLeft
@onready var beat: Timer = $beat
@onready var goal: Marker3D = $bg_view/bg_world/goal
const SALES_DODGE_SALES_R = preload("uid://bs5rrdfontsb2")

const timer_offset = 0
const measure_count = 8
var sequence = [
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
		assert(val.length == measure_count)
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
	print("beat")
