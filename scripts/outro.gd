extends Node2D
@export var results_ap: AnimationPlayer
@export var slides_at: AnimationTree

signal outro_finished

func _ready():
	slides_at.active = false
func play_outro():
	slides_at.active = true
	results_ap.play("showResults")
	slides_at["parameters/playback"].start("1")
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action1"):
		play_outro()


func _on_slides_slider_animation_finished(anim_name: StringName) -> void:
	if anim_name == '3':
		outro_finished.emit()
