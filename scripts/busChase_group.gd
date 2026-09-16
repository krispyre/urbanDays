extends Scene
@onready var fail: Node = $fail
@onready var win: Node = $win
@onready var level: Level = $level
@onready var transition: SubViewport = $transition
@onready var tr_anim: AnimationPlayer = $transition/anim

func _ready():
	fail.hide()
	win.hide()
	level.show()
	
func _on_level_win():
	win.show()
	tr_anim.play("zoom")
	await tr_anim.animation_finished
	level.hide()
	level.queue_free()
	print("win")


func _on_level_fail() -> void:
	fail.show()
	tr_anim.play("zoom")
	await tr_anim.animation_finished
	level.hide()
	level.queue_free()
	print("fail")
