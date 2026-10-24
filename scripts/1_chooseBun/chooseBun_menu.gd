extends GridContainer

@onready var chooser: Control = $"../chooser"

signal bun_selected(index:int)
signal bun_focused(index:int)

func _ready() -> void:
	var children = get_children()
	for i in range(children.size()):
		children[i].set_focus_mode(FocusMode.FOCUS_ALL)
		children[i].button_down.connect(func(): _on_bun_selected(i))
		children[i].focus_entered.connect(func(): _on_bun_focused(i))

	# Wait a frame so button sizes are laid out before first focus/move
	await get_tree().process_frame
	children[randi_range(0,6)].grab_focus()

#0 indexed
func _on_bun_selected(bun_index: int):
	prints("bun", bun_index, "selected")
	bun_selected.emit(bun_index)


func _on_bun_focused(bun_index: int):
	var center := (get_child(bun_index) as Control).get_global_rect().get_center()
	chooser.global_position = center
	prints("bun", bun_index, "focused")
	bun_focused.emit(bun_index)
