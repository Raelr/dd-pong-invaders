tool
extends Sprite

var is_paused : bool = false

export (bool) var is_player_one
export (bool) var is_player_two
export (bool) var update
export (Array) var playerTextures
export (float) var playerMovementSpeed

var y_upper_boundary = 483.57
var y_lower_boundary = 111.373
var timer = 0

var Bullet = preload("res://scenes/Bullet.tscn")
var canShoot = true
var isPlayerOneStunned = false
var isPlayerTwoStunned = false

func _ready():
	if (playerMovementSpeed == 0):
		playerMovementSpeed = 240 #default value for player movement speed
	print(OS.window_size)
	pass

func _process(delta):
	
	
	if not is_paused:
		control_player(delta)
		increase_speed()

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
			if (self.position.y > y_lower_boundary):
				self.position.y -= (playerMovementSpeed * delta)
		elif Input.is_key_pressed(KEY_S) and not Input.is_key_pressed(KEY_W):
			if (self.position.y < y_upper_boundary):
				self.position.y += (playerMovementSpeed * delta)
	elif (!is_player_one and !isPlayerTwoStunned):		
		catchUserShootInput()
		if Input.is_key_pressed(KEY_I) and not Input.is_key_pressed(KEY_K):
			if (self.position.y > y_lower_boundary):
				self.position.y -= playerMovementSpeed * delta
		elif Input.is_key_pressed(KEY_K) and not Input.is_key_pressed(KEY_I):
			if (self.position.y < y_upper_boundary):
				self.position.y += playerMovementSpeed * delta
			
#Speed increased by every minute
func increase_speed():
	timer += 1
	if (timer / 60000 == 1):
		playerMovementSpeed += 50
		timer = 0
		

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

