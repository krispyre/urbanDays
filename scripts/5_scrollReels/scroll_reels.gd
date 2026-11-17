extends Level
@onready var results_transition: ResultsTransition = $ResultsTransition

@export var reelList: VBoxContainer
@export var reelScene: PackedScene
func _on_win():
	if not mark_results_shown():
		return
	results_transition.play_win()

func _on_fail() -> void:
	if not mark_results_shown():
		return
	results_transition.play_fail()

func _ready() -> void:
	#init reel cards
	for i in range(5):
		var card = reelScene.instantiate()
		var title_count = card.find_child("title").sprite_frames.get_frame_count("default")
		var content_count = card.find_child("content").sprite_frames.get_frame_count("default")
		card.find_child("title").frame = randi_range(0,title_count-1)
		card.find_child("length").text = "0:"+"%02d" % (randi_range(1,6)*5+5)
		card.find_child("content").frame = randi_range(0,content_count-1)
		reelList.add_child(card)
		
	
