class_name ResultsTransition extends Node2D

## Green `transition` frames reveal `win` or `fail`.
## Frame count and speed stay on each AnimatedSprite2D.

@onready var transition: AnimatedSprite2D = $transition
@onready var viewport: SubViewport = $resultViewport
@onready var win: AnimatedSprite2D = %win
@onready var fail: AnimatedSprite2D = %fail


func _ready() -> void:
	var mat := (transition.material as ShaderMaterial).duplicate()
	transition.material = mat
	mat.set_shader_parameter(&"destTexture", viewport.get_texture())


func play_win() -> void:
	_play(win, fail, &"default")


## make sure fail variant name is fail
func play_fail() -> void:
	#try to get the fail in transition node, if theres none jus use default
	var trans_variant := &"default"
	var frames := transition.sprite_frames
	if frames and frames.has_animation(&"fail"):
		trans_variant = &"fail"
	_play(fail, win, trans_variant)

func _play(show_spr: AnimatedSprite2D, hide_spr: AnimatedSprite2D, trans_variant: StringName) -> void:
	hide_spr.visible = false
	hide_spr.stop()
	show_spr.visible = true
	_restart(show_spr)
	transition.animation = trans_variant
	transition.visible = true
	_restart(transition)


func _restart(spr: AnimatedSprite2D) -> void:
	var frames := spr.sprite_frames
	if frames == null:
		return
	var anim := spr.animation
	spr.frame = 0
	spr.play(anim)
