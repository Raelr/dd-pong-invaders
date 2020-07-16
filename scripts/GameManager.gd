extends Node2D

onready var paused : bool = false

func _ready():
	$MainMenu.connect("on_start", self, "start")

func start():
	$Arena.visible = true
	$PlayerOne.visible = true
	$PlayerTwo.visible = true
	$Camera2D.current = true
	$Camera2D.visible = true
