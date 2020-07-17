extends Area2D

var elapsed : float = 0.0
var ttl : float = 0.0
var update : bool = false
var is_powerup = true
var powerup_type : int = 0;

func start(type : int, duration : float):
	ttl = duration
	powerup_type = type
	update = true

func _process(delta):
	if update:
		elapsed += delta
		if elapsed >= ttl:
			queue_free()

func _on_Powerup_area_entered(area):
	# Do stuff
	if area.isBullet():
		get_parent().get_node("Main/PlayerOne" if area.player == "playerOne" else "Main/PlayerTwo").activatePowerup(powerup_type)
		queue_free()
