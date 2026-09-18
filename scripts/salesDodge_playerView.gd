extends Camera3D

@onready var goal: Marker3D = $"../goal"
var level_time
var z_speed
func _ready() -> void:
	level_time = 4.0 * owner.measure_count * 60.0 / Globals.bpm
	position.z = 0
	z_speed = goal.global_position.z/level_time
	#print(goal.global_position.z," ", z_speed, " ", level_time, " ", owner.measure_count)
	
func _physics_process(delta: float) -> void:
	position.z += z_speed*delta
