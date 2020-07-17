extends Control

signal on_resume

func _ready():
	$ResumeButton.connect("on_press", self, "start_game")
	$QuitButton.connect("on_press", self, "exit_game")
	$MainMenuButton.connect("on_press", self, "go_to_main_menu")

func resume_game() -> void:
	emit_signal("on_resume")

func go_to_main_menu() -> void:
	print("Main menu")

func exit_game():
	get_tree().quit()
