extends Sprite

func _ready():
	set_visible(true)
	# Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _input(event):
	if event is InputEventMouseMotion:
		global_position = get_viewport().get_mouse_position()
