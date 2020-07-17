extends Node2D

var playerOneHP = 100
var playerTwoHP = 100

func switch_tile_colors() -> void:
	$TileHalfLeft.swap_colors()
	$TileHalfRight.swap_colors()

func display_timer(is_player_one : bool, status : bool) -> void:
	if is_player_one:
		$PlayerOneTimer.visible = status
	else:
		$PlayerTwoTimer.visible = status

func increment_player_timer(delta : float, is_player_one : bool) -> void:
	if is_player_one:
		$PlayerOneTimer.text = str(int(delta) + 1)
	else:
		$PlayerTwoTimer.text = str(int(delta) + 1)
		
func lower_player_health(damage : int, isPlayerOne : bool):
	if (isPlayerOne):
		$PlayerOneHealth.value -= damage
		return $PlayerOneHealth.value
	else:
		$PlayerTwoHealth.value -= damage
		return $PlayerTwoHealth.value
		


	
