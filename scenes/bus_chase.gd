extends Level
@onready var goal: Area3D = $bus/goal
@onready var timer: Timer = $Timer
@onready var progress_bar: TextureProgressBar = $Container/ProgressBar

func _ready() -> void:
	progress_bar.max_value = timer.wait_time
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_bar.value = timer.time_left

#win condition
func _on_goal_body_entered(body: Node3D) -> void:
	win.emit()
	get_tree().paused = true
	print("win")


func _on_timer_timeout() -> void:
	fail.emit()
	get_tree().paused = true
	print("fail")
