extends Control

func _ready():
	$Replay.connect("on_press", self, "reset_game")
	$Menu.connect("on_press", self, "go_to_main")
	$Quit.connect("on_press", self, "exit_game")
	set_visible(false)

func set_visible(status: bool) -> void:
	visible = status
	$Replay.monitoring = status
	$Menu.monitoring = status
	$Quit.monitoring = status

func display_quit_menu(player : String):
	set_visible(true)
	get_parent().get_node("Main").queue_free()
	$Title.text = player + " won!"

func go_to_main():
	set_visible(false)
	get_parent().visible = true
	get_parent().reactivate_menu()
	

func reset_game():
	pass

func exit_game():
	get_tree().quit()

