extends Area3D
var warnTime = 0.5 #warn 0.5 seconds ahead
@onready var show_warn: Marker3D = $showWarn
@onready var player_view: CharacterBody3D = $"../playerView"

func _ready() -> void:
	show_warn.position.z = -player_view.velocity.z * warnTime
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
