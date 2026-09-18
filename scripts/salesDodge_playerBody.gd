extends Area2D

@onready var anim: AnimationPlayer = $anim

var dodge_time = .3
var dodge_length = 120

func _ready() -> void:
	anim.speed_scale = 1/ dodge_time		

func _process(delta: float) -> void:
	for dir in ["left", "right", "up", "down"]:
		if Input.is_action_just_pressed("ui_" + dir) and not anim.is_playing():
	
			var animation = anim.get_animation("dodge")
		
			#track 0 is x, 1 is y
			match dir: 
				"left":
					animation.bezier_track_set_key_value(0,0,-dodge_length)
					animation.bezier_track_set_key_value(1,0,0)
				"right":
					animation.bezier_track_set_key_value(0,0,dodge_length)
					animation.bezier_track_set_key_value(1,0,0)
				"up":
					animation.bezier_track_set_key_value(0,0,0)
					animation.bezier_track_set_key_value(1,0,-dodge_length)
				"down":
					animation.bezier_track_set_key_value(0,0,0)
					animation.bezier_track_set_key_value(1,0,dodge_length)
			print(animation.bezier_track_get_key_value(0,0))
			print(animation.bezier_track_get_key_value(1,0))
			print("ow")
			anim.play("dodge")
			
