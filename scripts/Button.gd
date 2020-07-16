tool
extends Area2D

export (String) var button_text
export (bool) var update

func _ready():
	update_label()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			if Input.is_action_just_pressed("lmb"):
				print("pressed" + button_text)

func update_label():
	$ButtonLabel.text = button_text

func _process(delta):
	if update:
		if Engine.editor_hint:
			update_label()
