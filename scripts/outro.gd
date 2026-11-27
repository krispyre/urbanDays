extends Node2D
@export var results_ap: AnimationPlayer
@export var slides_at: AnimationTree

@export var successful: Label
@export var fail: Label

signal outro_finished

var moreWins = true

func _ready():
	slides_at.active = false
func play_outro():
	slides_at.active = true
	results_ap.play("showResults")
	slides_at["parameters/playback"].start("1")
	
#idk how to make an anim tree so im doing a call method track idc
func flash_result():
	var tween = create_tween()
	if moreWins:
		successful.modulate = Color(0.482, 0.84, 0.227, 1.0)
		tween.tween_property(successful, "modulate",Color(1,1,1,1),1.5)
	else:
		fail.modulate = Color(0.84, 0.227, 0.227, 1.0)
		tween.tween_property(fail, "modulate",Color(1,1,1,1),1.5)

func _on_anim_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'showResults':
		outro_finished.emit()
	
