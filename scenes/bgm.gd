class_name bgm extends Node
signal nextLevel
signal outro
@onready var r: RhythmNotifier = $RhythmNotifier
var bpm = 175 # todo this is temp but salesdodge rely on that...
var is_over = false

const BEATS_PER_BAR := 4
const INTRO_BARS := 8
const LEVEL_BARS := 8
const LEVEL_COUNT := 8
const INTRO_BEATS := INTRO_BARS * BEATS_PER_BAR # 32
const LEVEL_BEATS := LEVEL_BARS * BEATS_PER_BAR # 32
## start this many beats early so the hint can play before the level section
const EARLY_OFFSET := 2

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
