extends Scene
@onready var intro: Node2D = $gameProcess/intro
@onready var level_nodes: Node = $gameProcess/levels
@export var pauseScreen: Control

@export var outro: Node2D

var lives = 3
var curLevel := -1
var cur_level_node: Node
var levels: Array[InstancePlaceholder] = []
@onready var levels_node: Node = $gameProcess/levels

func _unhandled_input(event: InputEvent):
	
	if (event.is_action_pressed("pause")):
		$gameProcess.get_tree().paused = !($gameProcess.get_tree().paused)
		set_music_vol(Globals.volume) # where is better idk
		if ($gameProcess.get_tree().paused):
			pauseScreen.show()
		else:
			print(Globals.volume)
			
			pauseScreen.hide()

func _ready() -> void:
	for child in level_nodes.get_children():
		levels.append(child as InstancePlaceholder)

func load_level(index: int) -> Node:
	var level := levels[index].create_instance(false)
	return level

func unload_level(level: Node) -> void:
	levels_node.remove_child(level)
	level.queue_free()

func _on_bgm_outro() -> void:
	print("play outro")
	outro.find_child("animPlayer").play("outro")

func _on_bgm_next_level() -> void:
	if curLevel == -1:
		#intro finish
		intro.hide()
		intro.queue_free()
	curLevel += 1
	prints("next level ", curLevel)
	if cur_level_node:
		unload_level(cur_level_node)
		
	if curLevel < bgm.LEVEL_COUNT:
		#load until the last one
		cur_level_node = load_level(curLevel)
	
## volume is 0 to 1 (float).
func set_music_vol(volume:float):
	%bgm.find_child("music_player").volume_db = linear_to_db(volume)+1
