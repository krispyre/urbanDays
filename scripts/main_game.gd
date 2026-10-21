extends Scene
@onready var intro: Node2D = $gameProcess/intro
@onready var level_nodes: Node = $gameProcess/levels

var lives = 3
var curLevel := -1
var cur_level_node: Node
var levels: Array[InstancePlaceholder] = []
@onready var levels_node: Node = $gameProcess/levels

func _unhandled_input(event: InputEvent):
	if (event.is_action_pressed("pause")):
		$gameProcess.get_tree().paused = !($gameProcess.get_tree().paused)

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

func _on_bgm_next_level() -> void:
	if curLevel == -1:
		#intro finish
		intro.hide()
		intro.queue_free()
	curLevel += 1
	prints("next level ", curLevel)
	if cur_level_node:
		unload_level(cur_level_node)
	cur_level_node = load_level(curLevel)
