extends Node
@onready var fail: Node = $fail
@onready var win: Node = $win
@onready var level: Level = $level

func _ready():
	fail.hide()
	win.hide()
	level.show()
	
func _on_level_win():
	win.show()
	level.hide()
	level.queue_free()
	get_tree().paused = true
	print("win")


func _on_level_fail() -> void:
	fail.show()
	level.hide()
	level.queue_free()
	get_tree().paused = true
	print("fail")
