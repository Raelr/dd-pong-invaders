extends Node2D

onready var paused : bool = false
onready var elapsed_time : float = 0.0;
onready var elapsed_time_player_one : float = 0.0;
onready var elapsed_time_player_two : float = 0.0;

export (float) var change_interval
export (float) var stun_interval

var player_one_stunned : bool = false
var player_two_stunned : bool = false

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
			$Arena.switch_tile_colors()
		if player_one_stunned:
			elapsed_time_player_one += delta
			$Arena.display_timer(true, true)
			if elapsed_time_player_one >= stun_interval:
				elapsed_time_player_one = 0
				player_one_stunned = false
				$Arena.display_timer(true, false)
			$Arena.increment_player_timer(elapsed_time_player_one, true)
		if player_two_stunned:
			elapsed_time_player_two += delta
			$Arena.display_timer(false, true)
			if elapsed_time_player_two >= stun_interval:
				elapsed_time_player_two = 0
				player_two_stunned = false
				$Arena.display_timer(false, false)
			$Arena.increment_player_timer(elapsed_time_player_two, false)

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
  $PowerupSpawner.is_paused = is_active
	
func game_over(playerWon):
	print(playerWon)
	pass

