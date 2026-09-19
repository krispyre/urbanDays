@tool
extends EditorScript

func _run() -> void:
	_apply_filter(EditorInterface.get_edited_scene_root())

func _apply_filter(node: Node) -> void:
	if node is Sprite3D:
		node.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	for child in node.get_children():
		_apply_filter(child)
	print("applied :)")
