extends Level

@onready var goal: Marker3D = $gameplay/bg_view/bg_world/goal
@onready var sales_container: Node = $gameplay/salesContainer

@onready var anim_player: AnimationPlayer = $animPlayer

const salesObj = preload("uid://bs5rrdfontsb2")
const Sales = preload("uid://cy2u3tgp0n6fs")

const measure_count = bgm.LEVEL_BARS
const WIN_BEAT := 18
var isFail = false
var start = false

#each sales appear at most on each beat
var sequence = [
	null,
	null,
	{"dir": "right"},
	null,
	{"dir": "left"},
	null,
	{"dir": "up"},
	null,
	{"dir": "down"},
]:
	set(val):
		assert(val.length <= measure_count * bgm.BEATS_PER_BAR)
		val.resize(measure_count * bgm.BEATS_PER_BAR)
		sequence = val

func _init() -> void:
	beat_offset = bgm.level_beat_offset(1)

func _level_ready() -> void:
	sequence.resize(measure_count * bgm.BEATS_PER_BAR)
	$animPlayer.play("showHint")

func _on_anim_finished(anim_name: StringName) -> void:
	if anim_name=="showHint":
		start = true
	
func on_beat(local_beat: int) -> void:
	prints("beat:", local_beat)
	
	if local_beat == WIN_BEAT:
		print("win?")
		#win or fail
		if (!isFail):
			win.emit()
			
	if local_beat >= sequence.size():
		return
	var step = sequence[local_beat]
	if step == null:
		return
	
	if !isFail:	
		var s = salesObj.instantiate()
		s.dir = step["dir"]
		sales_container.add_child(s)
			
			
func _on_fail():
	anim_player.play("showFail")
	
func _on_win() -> void:
	anim_player.play("showWin")

func _on_player_hit() -> void:
	print("die")
	isFail = true
	fail.emit()
