tool
extends Sprite

export (bool) var is_player_one
export (bool) var is_player_two
export (bool) var update
export (Array) var playerTextures
export (int) var playerMovementSpeed

var Bullet = preload("res://scenes/Bullet.tscn")
var canShoot = true
var isPlayerOneStunned = false
var isPlayerTwoStunned = false

func _ready():
	pass

func _process(delta):
	control_player(delta)
	
	
	if update:
		if Engine.editor_hint:
			texture = playerTextures[0] if (is_player_one) else playerTextures[1]

func catchUserShootInput():
	if (is_player_one):
		if Input.is_key_pressed(KEY_F):
			debounceShot(0, "playerOne")
	else:
		if Input.is_key_pressed(KEY_H):
			debounceShot(PI, "playerTwo")

func debounceShot(angle, player):
	if canShoot:
		shootBullet(angle, player)
		
		var recoilTimer = recoilTimer(1, "onRecoilTimerStopped")
		recoilTimer.start()
		canShoot = false


func shootBullet(angle, player):
	var bullet = Bullet.instance()
	
	bullet.start(global_position, angle, player)
	
	get_parent().add_child(bullet)

func onRecoilTimerStopped():
	canShoot = true

func control_player(delta):
	if (is_player_one and !isPlayerOneStunned):
		catchUserShootInput()
		if Input.is_key_pressed(KEY_W) and not Input.is_key_pressed(KEY_S):
			if (self.position.y > 111.373):
				self.position.y -= 5
		elif Input.is_key_pressed(KEY_S) and not Input.is_key_pressed(KEY_W):
			if (self.position.y < 483.579):
				self.position.y += 5
	elif (!is_player_one and !isPlayerTwoStunned):		
		catchUserShootInput()
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


func _on_Player2D_area_entered(area):
	if (is_player_one):
		if (area.isBullet() and area.getBulletOwner() == "playerTwo"):			
			var timer = recoilTimer(2, "playerOneRecovered")
			timer.start()
			isPlayerOneStunned = true
			area.queue_free()
	else:
		if (area.isBullet() and area.getBulletOwner() == "playerOne"):
			var timer = recoilTimer(2, "playerTwoRecovered")
			timer.start()
			isPlayerTwoStunned = true
			area.queue_free()
	pass # Replace with function body.

func playerOneRecovered():
	isPlayerOneStunned = false
	
func playerTwoRecovered():
	isPlayerTwoStunned = false

