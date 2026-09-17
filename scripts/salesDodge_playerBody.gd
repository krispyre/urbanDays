extends Area3D

@onready var anim: AnimationPlayer = $"../anim"
@onready var goal: Marker3D = $"../../goal"

var dodge_time = .3
var dodge_length = .8

func _ready() -> void:
	anim.speed_scale = 1/ dodge_time
	var i=0
	for dir in ["left", "right", "up", "down"]:
		var animation = anim.get_animation(dir)
		match dir:
			"left", "down":
				animation.bezier_track_set_key_value(0,0,-dodge_length)
			"right","up":
				animation.bezier_track_set_key_value(0,0,dodge_length)
		

func _process(delta: float) -> void:
	for dir in ["left", "right", "up", "down"]:
		if Input.is_action_just_pressed("ui_" + dir) and not anim.is_playing():
			print(anim.get_animation(dir).bezier_track_get_key_value(0,0))
			anim.play(dir)
			
