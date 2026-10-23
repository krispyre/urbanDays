extends Area2D

@onready var anim: AnimationPlayer = $anim

func _ready() -> void:
	anim.play("run")
	
	$spr.play("running", 1, )

func _process(delta: float) -> void:
	for dir in ["left", "right", "up", "down"]:
		if Input.is_action_just_pressed("ui_" + dir):
			anim.play(dir)

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name != "run":
		anim.play("run")
