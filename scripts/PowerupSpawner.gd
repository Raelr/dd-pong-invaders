extends Node2D

const Time_To_Power_Up = 5
const Time_To_Disappear = 5

var Elapsed_Time = 0
var is_paused : bool = false

var V2 = Vector2()

var Powerup_Scene = preload("res://scenes/Powerup.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_paused:
		Elapsed_Time += delta
		power_up_init()

func power_up_init():
	if Elapsed_Time >= Time_To_Power_Up:
		Elapsed_Time = 0
		power_up_generate()

func power_up_generate():
	# get a position on the arena
	
	# two random numbers
	var rand1 = randf() * 160
	var rand2 = randf() * 300
	
	# offset to the centre using static values
	V2.x = get_viewport().get_visible_rect().size.x / 2
	V2.y = rand2 + 300 - 150
	
	var powerup = Powerup_Scene.instance()
	get_tree().get_root().add_child(powerup)
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var type = rng.randf_range(0, 3)
	
	powerup.position = V2
	powerup.start(type, 5.0)
