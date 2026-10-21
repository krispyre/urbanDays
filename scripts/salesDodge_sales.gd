extends Node2D
@onready var anim_player: AnimationPlayer = $body/anim_player
@onready var hb: CollisionShape2D = $body/hb

enum direction {up, down, left, right}
@export var dir: direction = direction.up
var moved_away = 500 #starting point is this px away from the edge
var poke_amp = 80+moved_away # root goes from edge towards poke_amp inside. see sales_target ref
var hb_displace = 50 # hb displaces from root
var anim_time = 1

func dir_name() -> String:
	return direction.keys()[dir]

#1 sec 
# the peak should be on beat
func _ready() -> void:
	var facing := dir_name()
	for child in get_children()[0].get_children():
		if child is Sprite2D:
			child.visible = child.name == facing
				
	#displace hitbox
	match dir:
		direction.left:
			hb.position = Vector2(hb_displace,0)
		direction.right:
			hb.position = Vector2(-hb_displace,0)
		direction.up:
			hb.position = Vector2(0,hb_displace)
		direction.down:
			hb.position = Vector2(0,-hb_displace)
			
	#set anim
	anim_player.speed_scale = 1/anim_time
	var animation = anim_player.get_animation("buttIn")
	#track 0 is x, 1 is y
	#keyframes: origin, go towards player (Change this keyframe 1), orign
	#butt in towards the player
	match dir: 
		direction.left:
			animation.bezier_track_set_key_value(0,1,poke_amp)
			animation.bezier_track_set_key_value(1,1,0)
		direction.right:
			animation.bezier_track_set_key_value(0,1,-poke_amp)
			animation.bezier_track_set_key_value(1,1,0)
		direction.up:
			animation.bezier_track_set_key_value(0,1,0)
			animation.bezier_track_set_key_value(1,1,poke_amp)
		direction.down:
			animation.bezier_track_set_key_value(0,1,0)
			animation.bezier_track_set_key_value(1,1,-poke_amp)
	
	#align the animatino to peak at the next beat
	var b = 60.0/Globals.bpm
	var p = animation.track_get_key_time(0,1)
	prints(b,p)
	await get_tree().create_timer((b-p)*anim_player.speed_scale).timeout
	anim_player.play("buttIn")
	
func _process(dt):
	pass
	
