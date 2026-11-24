extends Level
@onready var results_transition: ResultsTransition = $ResultsTransition

@export var scrollContainer: ScrollContainer
@export var reelList: VBoxContainer
@export var reelScene: PackedScene
@export var fingerAnim: AnimatedSprite2D
@export var likeCount: AnimatedSprite2D
@export var likeTotal: AnimatedSprite2D
@export var likeCounterWhole:Node2D
@onready var lana_view: AnimatedSprite2D = $lanaView

signal scrollDown
signal scrollUp
signal like

var reel_count = 5
var curReel = 1 #1 indexed for counting children of the content list (0th is a msg) i LOVE hardcoding
var liked = [] #list of reels liked already or not

func _init():
	LEVEL_DURATION_BEAT = 15
func _on_win():
	if not mark_results_shown():
		return
	lana_view.play("finish")
	results_transition.play_win()

func _on_fail() -> void:
	if not mark_results_shown():
		return
	results_transition.play_fail()

func _level_ready() -> void:
	#init reel cards
	var card = reelScene.instantiate()
	var title_count = card.find_child("title").sprite_frames.get_frame_count("default")
	var content_count = card.find_child("content").sprite_frames.get_frame_count("default")
	var reelContent = random_n_numbers(0,content_count,reel_count)
	for i in range(reel_count):
		card = reelScene.instantiate()
		card.find_child("title").frame = randi_range(0,title_count-1)
		card.find_child("length").text = "0:"+"%02d" % (randi_range(1,6)*5+5)
		card.find_child("content").frame = reelContent[i]
		reelList.add_child(card)
		liked.append(false)
	likeCount.frame = 0
	likeTotal.frame = reel_count
	
		
func _input(e: InputEvent):
	if !game_start:
		return
	if scrollContainer.scrolling:
		return
	if e.is_action_pressed("down"):
		if curReel < reelList.get_child_count()-1:
			fingerAnim.play_backwards("scrollUp")
			curReel+= 1
			scrollDown.emit()
			
	if e.is_action_pressed("up"):
		if curReel >1:
			fingerAnim.play("scrollUp")
			curReel-= 1
			scrollUp.emit()
	if e.is_action_pressed("action1"):
		fingerAnim.play("tapLike")
		liked[curReel-1] = true
		like.emit()
		var count = 0
		for l in liked:
			if l:
				count+=1
		likeCount.frame = count
		if count == reel_count:
			likeCounterWhole.find_child("animPlayer").play("blinkCorrect")
			win.emit()
			
func _on_timer_timeout() -> void:
	lana_view.play("finish")
	
	if !isResultsShown:
		fail.emit()
	
