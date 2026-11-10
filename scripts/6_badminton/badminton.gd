extends Level

func _on_timer_timeout():
	print("owo")

func _on_floor_body_entered(body: Node2D) -> void:
	print("ball drops to floor, fail")
	
