class_name transitionMask extends AnimatedSprite2D

#this is so cursed Im crin
func _set_transition_destTexture(path: NodePath):
	var v := get_node(path) as SubViewport
	material.set_shader_parameter("destTexture", v.get_texture())
