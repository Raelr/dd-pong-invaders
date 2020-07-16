extends Node2D

onready var paused : bool = false
onready var elapsed_time : float = 0.0;
export (float) var change_interval

func _ready():
	$MainMenu.connect("on_start", self, "start")
	set_paused_state(true)

func _process(delta):
	if not paused:
		elapsed_time += delta
		if elapsed_time >= change_interval:
			elapsed_time = 0
			$PlayerOne.increase_speed()
			$PlayerTwo.increase_speed()

func start() -> void:
	$Arena.visible = true
	$PlayerOne.visible = true
	$PlayerTwo.visible = true
	$Camera2D.current = true
	$Camera2D.visible = true
	set_paused_state(false)

func set_paused_state(is_active : bool) -> void:
	print("Paused = " + ("true" if (is_active) else "false"))
	$PlayerOne.is_paused = is_active
	$PlayerTwo.is_paused = is_active

