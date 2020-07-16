tool 
extends Node2D

export (Color) var dark_color
export (Color) var light_color
export (bool) var update
export (float) var duration

var elapsed_time : float = 0.0

func _ready():
	sync_colors()

func _process(delta):
	if update:
		if Engine.editor_hint:
			sync_colors()
		elapsed_time += delta
		if elapsed_time < duration:
			$CheckerMarkDark.modulate = lerp($CheckerMarkDark.modulate, dark_color, elapsed_time/duration)
			$CheckerMarkLight.modulate = lerp($CheckerMarkLight.modulate, light_color, elapsed_time/duration)
		else: 
			elapsed_time = 0
			sync_colors()
			update = false

func sync_colors():
	$CheckerMarkDark.modulate = dark_color
	$CheckerMarkLight.modulate = light_color 

func swap_colors() -> void:
	var dark : Color = $CheckerMarkDark.modulate
	dark_color = $CheckerMarkLight.modulate
	light_color = dark
	update = true
	
