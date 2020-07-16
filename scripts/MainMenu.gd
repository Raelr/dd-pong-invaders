extends Control

signal on_start

export (NodePath) var game_scene

func _ready():
	$PlayButton.connect("on_press", self, "start_game")
	$QuitButton.connect("on_press", self, "exit_game")

func start_game():
	emit_signal("on_start")
	visible = false

func exit_game():
	get_tree().quit()
