class_name badmintonLana extends CharacterBody2D

@export var SPEED := 300
@onready var anim_spr: AnimatedSprite2D = $anim_spr
@onready var hit_cooldown: Timer = $hitCd

signal swing
var inputDisabled = false

func _physics_process(dt: float) -> void:
	if inputDisabled:
		return
	#print(hit_cooldown.time_left)
	var input_dir = Input.get_axis("left", "right")
	velocity.x = input_dir * SPEED
	
	if Input.is_action_just_pressed("action1"):
		if hit_cooldown.time_left > 0:
			return
		swing.emit()
		anim_spr.play("hit")
		hit_cooldown.start()
		await anim_spr.animation_finished
		anim_spr.play("default")
	move_and_slide()

func _on_miss_notice_body_entered(body: Node2D) -> void:
	anim_spr.play("miss")
	inputDisabled = true
	
