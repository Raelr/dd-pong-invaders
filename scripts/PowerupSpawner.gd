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
	
	powerup.position = V2
	powerup.start(2, 5.0)
	
# if is_expired true, remove the powerup with no action,
# otherwise activate powerup for player
func power_up_action(is_expired):
	var rand_num = 0
	if is_expired:
		# remove existing powerup from the arena
		pass
	else:
		# activate powerup
		# random number 1-3
		if rand_num == 1:
			# powerup 1
			pass
		elif rand_num == 2:
			# powerup 2
			pass
		else:
			# powerup 3
			pass
