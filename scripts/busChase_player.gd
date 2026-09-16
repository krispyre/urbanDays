extends CharacterBody3D
@onready var speed_label: Label = $Camera3D/debugLabel
@onready var bus: Node3D = $"../bus"

@export var PUSH_FORCE_MIN = 300
@export var PUSH_FORCE_MAX= 800
@export var DECCEL = 80
var pushForce

# todo change fov
func _ready() -> void:
	pushForce = PUSH_FORCE_MIN
	
func _physics_process(dt: float) -> void:
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("action1"):
		velocity.z = 0
		velocity.z -= pushForce * dt
	elif position.z <= 50:
		velocity.z += DECCEL * dt
	else:
		velocity.z = 0
		
	speed_label.text = "SPEED: "+str(velocity.z)+"m/s\n"+"Z: "+str(position.z)
	var t = position.z/(bus.position.z-0)#stronger push when closer?
	pushForce =  lerp(PUSH_FORCE_MAX, PUSH_FORCE_MIN, t)
	
	#print(pushForce)

	move_and_slide()
