extends Area2D

var elapsed : float = 0.0
var ttl : float = 0.0
var update : bool = false
var is_powerup = true
var powerup_type : int = 0;

var armour = preload("res://sprites/armour.png")
var bow = preload("res://sprites/bow.png")
var staff = preload("res://sprites/staff.png")

onready var power_up_sprite = get_node("Powerup")

func start(type : int, duration : float):	
	if  (type == 1):
		power_up_sprite.set_texture(armour)
	elif(type == 2):
		power_up_sprite.set_texture(bow)
	else:
		power_up_sprite.set_texture(staff)
	
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
		get_parent().get_node("Main/PlayerOne" if area.player == "playerOne" else "Main/PlayerTwo").activatePowerup(powerup_type, area.getBulletOwner())
		area.queue_free()
		queue_free()
