extends Area2D

@onready var anim_spr: AnimatedSprite2D = $animSpr
@onready var col_checks: Node = $colChecks

@onready var TILE_WIDTH = (1/ get_parent().scale.x) * 64
var TILE_HEIGHT = 64


var t = 0;
func _process(dt):
	if (t>1):
		t=1
	t+= dt
	anim_spr.position = lerp(anim_spr.position, Vector2(0,0), t)	

func _physics_process(delta: float) -> void:
	var step := Vector2(
		float(Input.is_action_just_pressed("right")) - float(Input.is_action_just_pressed("left")),
		float(Input.is_action_just_pressed("down")) - float(Input.is_action_just_pressed("up"))
	).normalized()
	if step == Vector2.ZERO:
		return
	
	var tile := Vector2(TILE_WIDTH, TILE_HEIGHT)
	t = 0
	
	for r in col_checks.get_children():
		if r.is_colliding():
			var dir = r.target_position.normalized()
			#prints("next to me, ", dir)
			
			if dir == step:
				print("blocked")
				anim_spr.position = 5 * step
				return
	position += step * tile
	anim_spr.position = -step * tile
