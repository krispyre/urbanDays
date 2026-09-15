extends CharacterBody3D
@onready var speed_label: Label = $Camera3D/debugLabel


@export var ACCEL = 200
@export var DECCEL = 80


func _physics_process(dt: float) -> void:
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("action1"):
		velocity.z = 0
		velocity.z -= ACCEL * dt
	elif position.z <= 50:
		velocity.z += DECCEL * dt
	else:
		velocity.z = 0
		
	speed_label.text = "SPEED: "+str(velocity.z)+"m/s\n"+"Z: "+str(position.z)

	move_and_slide()
