tool
extends Sprite

export (bool) var is_player_one
export (bool) var is_player_two
export (bool) var update
export (Array) var playerTextures
export (int) var playerMovementSpeed

var Bullet = preload("res://scenes/Bullet.tscn")
var canShoot = true

func _ready():
	pass

func _process(delta):
	control_player(delta)
	catchUserShootInput()
	
	if update:
		if Engine.editor_hint:
			texture = playerTextures[0] if (is_player_one) else playerTextures[1]

func catchUserShootInput():
	if (is_player_one):
		if Input.is_key_pressed(KEY_F):
			debounceShot(0)
	else:
		if Input.is_key_pressed(KEY_H):
			debounceShot(PI)

func debounceShot(angle):
	if canShoot:
		shootBullet(angle)
		
		var recoilTimer = recoilTimer(1, "onRecoilTimerStopped")
		recoilTimer.start()
		canShoot = false


func shootBullet(angle):
	var bullet = Bullet.instance()
	
	bullet.start(global_position, angle)
	
	get_parent().add_child(bullet)

func onRecoilTimerStopped():
	canShoot = true

func control_player(delta):
	if (is_player_one):
		if Input.is_key_pressed(KEY_W) and not Input.is_key_pressed(KEY_S):
			if (self.position.y > 111.373):
				self.position.y -= 5
		elif Input.is_key_pressed(KEY_S) and not Input.is_key_pressed(KEY_W):
			if (self.position.y < 483.579):
				self.position.y += 5
	else:
		if Input.is_key_pressed(KEY_I) and not Input.is_key_pressed(KEY_K):
			if (self.position.y > 111.373):
				self.position.y -= 5
		elif Input.is_key_pressed(KEY_K) and not Input.is_key_pressed(KEY_I):
			if (self.position.y < 483.579):
				self.position.y += 5

func recoilTimer(time, callback):

	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.connect("timeout", self, callback)
	timer.set_wait_time(time)
	
	self.add_child(timer)
	
	return timer
