extends Level

@onready var goal: Marker3D = $gameplay/bg_view/bg_world/goal
@onready var sales_container: Node = $gameplay/salesContainer

@onready var fail_spr: Node = $fail
@onready var win_spr: Node = $win

const salesObj = preload("uid://bs5rrdfontsb2")
const Sales = preload("uid://cy2u3tgp0n6fs")

const measure_count = 8
var isFail = false

#each sales appear at most on each beat
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
]:
	set(val):
		assert(val.length <= measure_count * 4)
		val.resize(measure_count * 4)
		sequence = val

func _init() -> void:
	beat_offset = 8 * 4 - 1 + 8 * 1
	# intro + 1 level before

func _level_ready() -> void:
	win_spr.hide()
	fail_spr.hide()
	sequence.resize(measure_count * 4)

func _on_player_body_area_entered(_area: Area2D) -> void:
	print("die")
	#isFail = true
	#fail.emit()

func on_beat(local_beat: int) -> void:
	prints("beat:", local_beat)
	
	if local_beat == 12:
		print("win?")
		#win or fail
		if (!isFail):
			win.emit()
			
	if local_beat >= sequence.size():
		return
	var step = sequence[local_beat]
	if step == null:
		return
	
	var s = salesObj.instantiate()
	s.dir = step["dir"]
	sales_container.add_child(s)
			
			
func _on_fail():
	fail_spr.show()
	win_spr.hide()
	
func _on_win() -> void:
	fail_spr.hide()
	win_spr.show()
