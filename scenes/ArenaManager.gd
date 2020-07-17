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
export (int) var paddingLength = 3
var playerOneScore = 0
var playerTwoScore = 0
func _ready():
	update()

func reset():
	playerOneScore = 0
	playerTwoScore = 0
	update()

func adjust(adjustment, is_player_one : bool):
	if is_player_one:
		playerOneScore += adjustment
	elif not is_player_one:
		playerTwoScore += adjustment
	update()

func update():
	$PlayerOneScore.text = ("%*d" % [paddingLength, playerOneScore])
	$PlayerTwoScore.text = ("%*d" % [paddingLength, playerTwoScore])
