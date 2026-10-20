class_name bgm extends Node

@onready var r: RhythmNotifier = $RhythmNotifier
var bpm
func _ready():
	bpm = $music_player.stream.bpm
	r.bpm = bpm
	r.beats(0,false,8*4).connect(func(count): prints("endIntro",count))
	r.beats(4*4,true,8*4).connect(func(count): prints("nextlevel"))
	
	
