tool
extends Sprite

export (bool) var is_player_one
export (bool) var update
export (Array) var playerTextures

var Bullet = preload("res://scenes/Bullet.tscn")
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

func _input(event):
	if event is InputEventMouseButton:
		mousePressed(event)

func mousePressed(event):
	if canShoot:
		print("Mouse pressed")
		shootBullet(event)
		
		# recoilTimer.start()
		# canShoot = false


func shootBullet(event):
	var bullet = Bullet.instance()
	
	bullet.start(global_position, rotation)
	
	get_parent().add_child(bullet)


func onRecoilTimerStopped():
	canShoot = true
