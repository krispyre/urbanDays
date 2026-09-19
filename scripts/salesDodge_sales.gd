extends Node2D
@onready var anim_player: AnimationPlayer = $body/anim_player
@onready var hb: CollisionShape2D = $body/hb

var dir := "up"
var moved_away = 500 #starting point is this px away from the edge
var poke_amp = 80+moved_away # root goes from edge towards poke_amp inside. see sales_target ref
var hb_displace = 50 # hb displaces from root
var anim_time = 1
func _ready() -> void:
	assert (dir == "up" or dir == "down" or dir == "left" or dir == "right")
	for child in get_children()[0].get_children():
		if child is Sprite2D:
			if child.name == dir:
				child.visible = true
			else:
				child.visible = false
				
	#displace hitbox
	match dir:
		"left":
			hb.position = Vector2(hb_displace,0)
		"right":
			hb.position = Vector2(-hb_displace,0)
		"up":
			hb.position = Vector2(0,hb_displace)
		"down":
			hb.position = Vector2(0,-hb_displace)
			
	#set anim
	anim_player.speed_scale = 1/anim_time
	var animation = anim_player.get_animation("buttIn")
	#track 0 is x, 1 is y
	#keyframes: origin, go towards player (Change this keyframe 1), orign
	#butt in towards the player
	match dir: 
		"left":
			animation.bezier_track_set_key_value(0,1,poke_amp)
			animation.bezier_track_set_key_value(1,1,0)
		"right":
			animation.bezier_track_set_key_value(0,1,-poke_amp)
			animation.bezier_track_set_key_value(1,1,0)
		"up":
			animation.bezier_track_set_key_value(0,1,0)
			animation.bezier_track_set_key_value(1,1,poke_amp)
		"down":
			animation.bezier_track_set_key_value(0,1,0)
			animation.bezier_track_set_key_value(1,1,-poke_amp)
	
	anim_player.play("buttIn")
	
func _process(dt):
	if $body.position.x != 0:
		print($body.position.x)
	
