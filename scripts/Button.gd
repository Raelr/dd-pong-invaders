tool
extends Area2D

signal on_press

export (String) var button_text
export (bool) var update

func _ready():
	update_label()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			if Input.is_action_just_pressed("lmb"):
				emit_signal("on_press")

func update_label():
	$ButtonLabel.text = button_text

func _process(delta):
	if update:
		if Engine.editor_hint:
			update_label()


func _on_Button_mouse_entered():
	$ButtonLabel.modulate = Color(0.0, 0.0, 0.0, 1.0)




func _on_Button_mouse_exited():
	$ButtonLabel.modulate = Color(1.0,1.0,1.0,1.0)
