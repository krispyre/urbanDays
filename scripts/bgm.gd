class_name bgm extends Node
signal nextLevel
signal outro

@export var music_player: AudioStreamPlayer

@onready var r: RhythmNotifier = $RhythmNotifier
static var bpm = 175 # todo this is temp but salesdodge rely on that...
var is_over = false

const BEATS_PER_BAR := 4
const INTRO_BARS := 8
const LEVEL_BARS := 8
const LEVEL_COUNT := 7
const EARLY_OFFSET := 2
const INTRO_BEATS := INTRO_BARS * BEATS_PER_BAR # 32
const LEVEL_BEATS := LEVEL_BARS * BEATS_PER_BAR # 32
## start this many beats early so the hint can play before the level section

## lv is 1-indexed (first gameplay level = 1)
static func level_beat_offset(lv: int) -> int:
	return INTRO_BEATS + LEVEL_BEATS * (lv - 1) - EARLY_OFFSET

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
	r.beats(LEVEL_BEATS, true, INTRO_BEATS).connect(emitNextLevel)
	#outro
	r.beats(0, false, INTRO_BEATS + LEVEL_BEATS * LEVEL_COUNT).connect(emitOutro)
	prints(INTRO_BEATS + LEVEL_BEATS * LEVEL_COUNT, (INTRO_BEATS + LEVEL_BEATS * LEVEL_COUNT)*60/bpm)
	
func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("skip")):
		prints(music_player.get_playback_position())
		music_player.seek(music_player.get_playback_position()+60/bpm)
	if (event.is_action_pressed("outro")):
		music_player.seek((INTRO_BEATS + LEVEL_BEATS * LEVEL_COUNT)*60/bpm)
		emitOutro(67)
