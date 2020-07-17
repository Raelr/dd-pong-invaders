extends Control

func _ready():
	$Replay.connect("on_press", self, "reset_game")
	$Menu.connect("on_press", self, "go_to_main")
	$Quit.connect("on_press", self, "exit_game")

func go_to_main():
	pass

func reset_game():
	pass

func exit_game():
	get_tree().quit()

