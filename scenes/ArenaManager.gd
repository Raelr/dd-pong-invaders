extends Node2D

func switch_tile_colors() -> void:
	$TileHalfLeft.swap_colors()
	$TileHalfRight.swap_colors()

func display_timer(is_player_one : bool) -> void:
	if is_player_one:
		$PlayerOneTimer.visible = true
	else:
		$PlayerTwoTimer.visible = true

func increment_player_timer(delta : float, is_player_one : bool) -> void:
	if is_player_one:
		$PlayerOneTimer.text = str(int(delta))
	else:
		$PlayerTwoTimer.text = str(int(delta))
