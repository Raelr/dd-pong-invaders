tool
extends Sprite

export (bool) var is_player_one
export (bool) var update
export (Array) var playerTextures

var BulletInterval = 0.3

var recoilTimer
var bulletSpawnFrom

var mousePosition
var aimPosition

var canShoot = true

var bullet

func _ready():
	pass

func _process(_delta):
	if update:
		if Engine.editor_hint:
			texture = playerTextures[0] if (is_player_one) else playerTextures[1]
			
func _physics_process(_delta):
	# mouse look
	mousePosition = get_global_mouse_position()
	aimPosition = mousePosition
	bulletSpawnFrom = mousePosition
	
	# $PointerOne.look_at(mousePosition)
	
	# aimPosition = to_global($PointerOne.position)
	
	# Fire weapon
	if InputEvent:
		mousePressed()

func mousePressed():
	if canShoot:
		shootBullet()
		
		# recoilTimer.start()
		
		canShoot = false


func shootBullet():
	bullet = $BulletOne
	
	# bullet.position = bulletSpawnFrom
	
	# bullet.add_to_group("missiles")
	
	get_tree().get_root().add_child(bullet)


func onRecoilTimerStopped():
	canShoot = true
