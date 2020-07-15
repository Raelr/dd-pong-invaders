tool 
extends Node2D

export (Color) var dark_color
export (Color) var light_color
export (bool) var update

func _ready():
	sync_colors()

func _process(delta):
	if update:
		if Engine.editor_hint:
			sync_colors()

func sync_colors():
	$CheckerMarkDark.modulate = dark_color
	$CheckerMarkLight.modulate = light_color 
