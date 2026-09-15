extends CharacterBody3D
@onready var speed_label: Label = $Camera3D/debugLabel


@export var PUSH_FORCE = 800
@export var DECCEL = 80

# todo change fov

func _physics_process(dt: float) -> void:
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("action1"):
		velocity.z = 0
		velocity.z -= PUSH_FORCE * dt
	elif position.z <= 50:
		velocity.z += DECCEL * dt
	else:
		velocity.z = 0
		
	speed_label.text = "SPEED: "+str(velocity.z)+"m/s\n"+"Z: "+str(position.z)
	print(PUSH_FORCE)

	move_and_slide()
