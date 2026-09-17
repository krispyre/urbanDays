extends CharacterBody3D

@onready var goal: Marker3D = $"../goal"
@onready var player_body: Area3D = $playerBody

var level_time = 5

func _ready() -> void:
	position.z = -6
	var s = goal.global_position.z - player_body.global_position.z
	velocity.z = s/level_time
	#print(goal.position.z," ", player_body.position.z," ", velocity.z)
	
func _physics_process(delta: float) -> void:
	move_and_slide()
