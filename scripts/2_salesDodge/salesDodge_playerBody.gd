extends Area2D

@onready var anim: AnimationPlayer = $anim
@onready var spr: AnimatedSprite2D = $spr

var can_move := true

func _ready() -> void:
	anim.play("run")
	spr.play("running")

func _process(_delta: float) -> void:
	if not can_move or not owner.start:
		return
	for dir in ["left", "right", "up", "down"]:
		if Input.is_action_just_pressed("ui_" + dir):
			anim.play(dir)

func play_relieve() -> void:
	if not can_move:
		return
	can_move = false
	anim.play("relieve")

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name in ["left", "right", "up", "down"]:
		anim.play("run")
