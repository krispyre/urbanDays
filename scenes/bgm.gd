class_name bgm extends Node
signal globalBeat(beatCount:int)
signal nextLevel
signal outro
@onready var r: RhythmNotifier = $RhythmNotifier
var bpm = 175 #todo this is temp but salesdodge rely on that...
var is_over = false

func emitNextLevel(count):
	if !is_over:
		nextLevel.emit()
func emitOutro(count):
	is_over = true
	outro.emit()
	
func _ready():
	bpm = $music_player.stream.bpm
	r.bpm = bpm
	r.beats(1).connect(globalBeat.emit)
	#nextLevel, stop when isOver is true
	r.beats(4*4,true,8*4).connect(emitNextLevel)
	#outro
	r.beats(0,false,(8+4*8)*4).connect(emitOutro)
	
	
