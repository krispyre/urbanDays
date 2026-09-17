extends Area3D

@onready var anim: AnimationPlayer = $"../anim"
@onready var goal: Marker3D = $"../../goal"

var dodge_time = .2

func _ready() -> void:
	anim.speed_scale = 1/ dodge_time
	for dir in ["left", "right", "up", "down"]:
		var animation = anim.get_animation("my_animation")
		var track = animation.find_track("MyNode:position", Animation.TYPE_VALUE)

		animation.track_set_key_value(
			track,
			i,
			Vector2(300, 150)
		)

func _process(delta: float) -> void:
	for dir in ["left", "right", "up", "down"]:
		if Input.is_action_just_pressed("ui_" + dir) and not anim.is_playing():
			print(anim.speed_scale)
			anim.play(dir)
			
