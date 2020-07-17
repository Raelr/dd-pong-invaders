tool
extends Area2D

signal on_press

export (String) var button_text
export (bool) var update
export (Color) var normal_color
export (Color) var hover_color

func _ready():
	update_label()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			if Input.is_action_just_pressed("fire"):
				emit_signal("on_press")

func update_label():
	$ButtonLabel.text = button_text
	$ButtonLabel.modulate = normal_color

func _process(delta):
	if update:
		if Engine.editor_hint:
			update_label()

func _on_Button_mouse_entered():
	$ButtonLabel.modulate = hover_color

func _on_Button_mouse_exited():
	$ButtonLabel.modulate = normal_color

func isBullet():
	return false
