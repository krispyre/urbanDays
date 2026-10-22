extends Node2D
@onready var sales_anim_player: AnimationPlayer = $sales_animPlayer
@onready var warn_anim_player: AnimationPlayer = $warn_animPlayer
@onready var hb: CollisionShape2D = $body/hb

var dir := "up"

# the peak should be on beat
func _ready() -> void:
	assert (dir == "up" or dir == "down" or dir == "left" or dir == "right")
	$body.hide()
	warn_anim_player.play(dir)
	
	

	#
	##align the animatino to peak at the next beat????
	#var b = 60.0/Globals.bpm
	#var p = animation.track_get_key_time(0,1)
	#prints(b,p)
	#await get_tree().create_timer((b-p)*sales_anim_player.speed_scale).timeout
	#sales_anim_player.play("buttIn")
	

func _on_warn_anim_finished(anim_name: StringName) -> void:
	$body.show()
	sales_anim_player.play(anim_name)
