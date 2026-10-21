class_name bgm extends Node
signal nextLevel
signal outro
@onready var r: RhythmNotifier = $RhythmNotifier
var bpm = 175 # todo this is temp but salesdodge rely on that...
var is_over = false

func emitNextLevel(_count):
	if !is_over:
		nextLevel.emit()
func emitOutro(_count):
	is_over = true
	outro.emit()
	
func _ready():
	bpm = $music_player.stream.bpm
	r.bpm = bpm
	# r.beat is already a signal jus reuse it
	#nextLevel, stop when isOver is true
	r.beats(4 * 4, true, 8 * 4).connect(emitNextLevel)
	#outro
	r.beats(0, false, (8 + 4 * 8) * 4).connect(emitOutro)
