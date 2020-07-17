extends Control

signal on_start

func _ready():
	$PlayButton.connect("on_press", self, "start_game")
	$QuitButton.connect("on_press", self, "exit_game")

func start_game():
	$ColorRect.visible = false
	$Title.visible = false
	$PlayButton.visible = false
	$PlayButton.monitoring = false
	$PlayButton.monitoring = false
	$QuitButton.visible = false
	var main_menu = preload("res://scenes/Main.tscn")
	var game = main_menu.instance()
	add_child(game)
	game.start()

func reactivate_menu():
	$ColorRect.visible = true
	$Title.visible = true
	$PlayButton.visible = true
	$PlayButton.monitoring = true
	$PlayButton.monitoring = true
	$QuitButton.visible = true

func exit_game():
	get_tree().quit()

func player_won(player : String):
	$EndScreen.display_quit_menu(player)
