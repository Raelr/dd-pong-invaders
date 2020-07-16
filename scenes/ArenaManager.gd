extends Node2D

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
