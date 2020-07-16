extends Control

export (NodePath) var game_scene

func _ready():
	$PlayButton.connect("on_press", self, "start_game")
	$QuitButton.connect("on_press", self, "exit_game")

func start_game():
	get_parent().get_node("Arena").visible = true
	get_parent().get_node("PlayerOne").visible = true
	get_parent().get_node("PlayerTwo").visible = true
	visible = false

func exit_game():
	get_tree().quit()
