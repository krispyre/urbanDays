extends Node2D
@onready var sales_anim_player: AnimationPlayer = $sales_animPlayer
@onready var warn_anim_player: AnimationPlayer = $warn_animPlayer
@onready var hb: CollisionShape2D = $body/hb

var dir := "up"

func _ready() -> void:
	assert (dir == "up" or dir == "down" or dir == "left" or dir == "right")
	$body.hide()
	var a = sales_anim_player.get_animation(dir)
	a.length = .343-.133 #i dont wanna change by hand idc
	warn_anim_player.play(dir)

func _on_warn_anim_finished(anim_name: StringName) -> void:
	$warn.hide()
	$body.show()
	sales_anim_player.play(anim_name)


func _on_sales_anim_finished(anim_name: StringName) -> void:
	queue_free()
