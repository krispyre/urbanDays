extends TextureButton

var normalTexture
@export var focusTexture: Texture2D

func _ready() -> void:
	normalTexture = texture_normal
	
func _on_focus_entered() -> void:
	texture_normal = focusTexture

func _on_focus_exited() -> void:
	texture_normal = normalTexture
